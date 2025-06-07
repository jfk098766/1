package sos.passportapplet;

import javacard.framework.APDU;
import javacard.framework.AID;
import javacard.framework.Applet;
import javacard.framework.CardRuntimeException;
import javacard.framework.ISO7816;
import javacard.framework.ISOException;
import javacard.framework.JCSystem;
import javacard.framework.Util;
import javacard.security.RandomData;
import javacard.security.Signature;

/**
 * Single-File PassportApplet with Pre-created Files
 * 
 * Features:
 * - Standard ICAO e-passport AID: A0000002471001
 * - Pre-created files: EF.COM, EF.DG1, EF.DG2, EF.SOD
 * - BAC (Basic Access Control) with mandatory Secure Messaging
 * - Ready for automated deployment
 * 
 * @author Perfected for automated deployment
 */
public class PassportApplet extends Applet implements ISO7816 {
    
    // Standard e-passport AID as per ICAO 9303
    private static final byte[] PASSPORT_AID = {
        (byte)0xA0, 0x00, 0x00, 0x00, 0x02, 0x47, 0x10, 0x01
    };
    
    // File sizes (typical values)
    private static final short EF_COM_SIZE = 64;     // Usually small
    private static final short EF_DG1_SIZE = 128;    // MRZ for TD3
    private static final short EF_DG2_SIZE = 20480;  // 20KB for facial image
    private static final short EF_SOD_SIZE = 2048;   // Security object
    
    // Volatile state flags (reset on power loss)
    static byte volatileState[];
    static final byte CHALLENGED = 1;
    static final byte MUTUAL_AUTHENTICATED = 2;
    static final byte FILE_SELECTED = 4;

    // Persistent state flags (stored in EEPROM)
    static byte persistentState;
    static final byte HAS_MUTUALAUTHENTICATION_KEYS = 1;
    static final byte LOCKED = 4;

    // APDU instruction codes
    static final byte INS_EXTERNAL_AUTHENTICATE = (byte) 0x82;
    static final byte INS_GET_CHALLENGE = (byte) 0x84;
    static final byte INS_SELECT_FILE = (byte) 0xA4;
    static final byte INS_READ_BINARY = (byte) 0xB0;
    static final byte INS_UPDATE_BINARY = (byte) 0xD6;
    static final byte INS_CREATE_FILE = (byte) 0xE0;
    static final byte INS_PUT_DATA = (byte) 0xDA;
    
    static final byte CLA_PROTECTED_APDU = 0x0C;

    // Cryptographic constants
    static final short KEY_LENGTH = 16;
    static final short KEYMATERIAL_LENGTH = 16;
    static final short RND_LENGTH = 8;
    static final short MAC_LENGTH = 8;

    // Personalization tags
    private static final byte MRZ_TAG = 0x62;

    // Status words
    private static final short SW_OK = (short) 0x9000;
    static final short SW_INTERNAL_ERROR = (short) 0x6D66;

    // Instance fields
    private byte[] rnd;
    private byte[] ssc;
    private FileSystem fileSystem;
    private RandomData randomData;
    private short selectedFile;
    private PassportCrypto crypto;
    private PassportInit init;
    private KeyStore keyStore;

    /**
     * Constructor - initializes the applet with pre-created files
     */
    public PassportApplet() {
        // Initialize file system with pre-created files
        fileSystem = new FileSystem();
        fileSystem.initializeFiles();
        
        randomData = RandomData.getInstance(RandomData.ALG_PSEUDO_RANDOM);
        keyStore = new KeyStore(PassportCrypto.JCOP41_MODE);
        crypto = new JCOP41PassportCrypto(keyStore);
        init = new PassportInit(crypto);
        
        // Allocate transient arrays
        rnd = JCSystem.makeTransientByteArray(RND_LENGTH, JCSystem.CLEAR_ON_RESET);
        ssc = JCSystem.makeTransientByteArray((byte) 8, JCSystem.CLEAR_ON_RESET);
        volatileState = JCSystem.makeTransientByteArray((byte) 1, JCSystem.CLEAR_ON_RESET);
    }

    /**
     * Applet installation with standard e-passport AID
     */
    public static void install(byte[] buffer, short offset, byte length) {
        // Create applet instance
        PassportApplet applet = new PassportApplet();
        
        // Register with standard e-passport AID
        applet.register(PASSPORT_AID, (short)0, (byte)PASSPORT_AID.length);
    }

    /**
     * Main APDU processing entry point
     */
    public void process(APDU apdu) {
        if (selectingApplet()) {
            return;
        }

        byte[] buffer = apdu.getBuffer();
        byte cla = buffer[OFFSET_CLA];
        byte ins = buffer[OFFSET_INS];
        short sw1sw2 = SW_OK;
        boolean protectedApdu = (byte)(cla & CLA_PROTECTED_APDU) == CLA_PROTECTED_APDU;
        short responseLength = 0;
        short le = 0;

        // Unwrap secure messaging if needed
        if (protectedApdu && hasMutuallyAuthenticated()) {
            try {
                le = crypto.unwrapCommandAPDU(ssc, apdu);
            } catch (CardRuntimeException e) {
                sw1sw2 = e.getReason();
            }
        } else if (protectedApdu) {
            ISOException.throwIt(ISO7816.SW_SECURE_MESSAGING_NOT_SUPPORTED);
        }

        // Process the APDU
        if (sw1sw2 == SW_OK) {
            try {
                responseLength = processAPDU(apdu, cla, ins, protectedApdu, le);
            } catch (CardRuntimeException e) {
                sw1sw2 = e.getReason();
            }
        }

        // Wrap response with secure messaging if needed
        if (protectedApdu && hasMutuallyAuthenticated()) {
            responseLength = crypto.wrapResponseAPDU(ssc, apdu, 
                crypto.getApduBufferOffset(responseLength), responseLength, sw1sw2);
        }

        // Send response
        if (responseLength > 0) {
            if (apdu.getCurrentState() != APDU.STATE_OUTGOING)
                apdu.setOutgoing();
            if (apdu.getCurrentState() != APDU.STATE_OUTGOING_LENGTH_KNOWN)
                apdu.setOutgoingLength(responseLength);
            apdu.sendBytes((short) 0, responseLength);
        }

        if (sw1sw2 != SW_OK) {
            ISOException.throwIt(sw1sw2);
        }
    }

    /**
     * APDU command dispatcher
     */
    public short processAPDU(APDU apdu, byte cla, byte ins, boolean protectedApdu, short le) {
        short responseLength = 0;

        switch (ins) {
            case INS_GET_CHALLENGE:
                responseLength = processGetChallenge(apdu);
                break;
            case INS_EXTERNAL_AUTHENTICATE:
                responseLength = processMutualAuthenticate(apdu);
                break;
            case INS_SELECT_FILE:
                responseLength = processSelectFile(apdu);
                break;
            case INS_READ_BINARY:
                responseLength = processReadBinary(apdu, le, protectedApdu);
                break;
            case INS_UPDATE_BINARY:
                processUpdateBinary(apdu, protectedApdu);
                break;
            case INS_PUT_DATA:
                processPutData(apdu);
                break;
            default:
                ISOException.throwIt(SW_INS_NOT_SUPPORTED);
                break;
        }
        return responseLength;
    }

    /**
     * Process GET_CHALLENGE - Start of BAC protocol
     */
    private short processGetChallenge(APDU apdu) {
        if (!hasMutualAuthenticationKeys() || hasMutuallyAuthenticated()) {
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);
        }
        
        short le = apdu.setOutgoing();
        
        if (le != 8) {
            ISOException.throwIt(SW_WRONG_LENGTH);
        }
        
        byte[] buffer = apdu.getBuffer();
        randomData.generateData(rnd, (short) 0, le);
        Util.arrayCopyNonAtomic(rnd, (short) 0, buffer, (short) 0, le);
        
        volatileState[0] |= CHALLENGED;
        return le;
    }

    /**
     * Process EXTERNAL_AUTHENTICATE - Complete BAC protocol
     */
    private short processMutualAuthenticate(APDU apdu) {
        if (!isChallenged() || hasMutuallyAuthenticated()) {
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);
        }

        byte[] buffer = apdu.getBuffer();
        short bytesLeft = (short) (buffer[OFFSET_LC] & 0x00FF);
        short e_ifd_length = RND_LENGTH + RND_LENGTH + KEYMATERIAL_LENGTH;

        if (bytesLeft != (short) (e_ifd_length + MAC_LENGTH))
            ISOException.throwIt(SW_WRONG_LENGTH);

        short e_ifd_p = OFFSET_CDATA;
        short m_ifd_p = (short) (e_ifd_p + e_ifd_length);

        if (apdu.getCurrentState() == APDU.STATE_INITIAL) {
            apdu.setIncomingAndReceive();
        }

        // Verify MAC
        crypto.initMac(Signature.MODE_VERIFY);
        if (!crypto.verifyMacFinal(buffer, e_ifd_p, e_ifd_length, buffer, m_ifd_p))
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);

        // Decrypt
        crypto.decryptInit();
        crypto.decryptFinal(buffer, e_ifd_p, e_ifd_length, buffer, (short) 0);

        short rnd_ifd_p = 0;
        short rnd_icc_p = RND_LENGTH;
        short k_ifd_p = (short) (rnd_icc_p + RND_LENGTH);

        // Verify RND.ICC
        if (Util.arrayCompare(buffer, rnd_icc_p, rnd, (short) 0, RND_LENGTH) != 0)
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);

        // Generate K.ICC
        short k_icc_p = (short) (k_ifd_p + KEYMATERIAL_LENGTH);
        short keySeed_p = (short) (k_icc_p + KEYMATERIAL_LENGTH);
        short keys_p = (short) (keySeed_p + KEYMATERIAL_LENGTH);

        randomData.generateData(buffer, k_icc_p, KEYMATERIAL_LENGTH);

        // Calculate keySeed = K.IFD XOR K.ICC
        PassportUtil.xor(buffer, k_ifd_p, buffer, k_icc_p, buffer, keySeed_p, KEYMATERIAL_LENGTH);

        // Derive session keys
        crypto.deriveKey(buffer, keySeed_p, KEYMATERIAL_LENGTH, PassportCrypto.MAC_MODE, keys_p);
        short macKey_p = keys_p;
        keys_p += KEY_LENGTH;
        crypto.deriveKey(buffer, keySeed_p, KEYMATERIAL_LENGTH, PassportCrypto.ENC_MODE, keys_p);
        short encKey_p = keys_p;
        keyStore.setSecureMessagingKeys(buffer, macKey_p, buffer, encKey_p);

        // Compute SSC
        PassportCrypto.computeSSC(buffer, rnd_icc_p, buffer, rnd_ifd_p, ssc);

        // Create response: RND.ICC || RND.IFD || K.ICC
        PassportUtil.swap(buffer, rnd_icc_p, rnd_ifd_p, RND_LENGTH);
        Util.arrayCopyNonAtomic(buffer, k_icc_p, buffer, (short) (2 * RND_LENGTH), KEYMATERIAL_LENGTH);

        // Encrypt response
        crypto.encryptInit();
        short ciphertext_len = crypto.encryptFinal(buffer, (short) 0,
                (short) (2 * RND_LENGTH + KEYMATERIAL_LENGTH), buffer, (short) 0);

        // Create MAC
        crypto.initMac(Signature.MODE_SIGN);
        crypto.createMacFinal(buffer, (short) 0, ciphertext_len, buffer, ciphertext_len);

        setNoChallenged();
        volatileState[0] |= MUTUAL_AUTHENTICATED;

        return (short) (ciphertext_len + MAC_LENGTH);
    }

    /**
     * Process SELECT_FILE
     */
    private short processSelectFile(APDU apdu) {
        if (isLocked() && !hasMutuallyAuthenticated()) {
            ISOException.throwIt(ISO7816.SW_SECURITY_STATUS_NOT_SATISFIED);
        }

        byte[] buffer = apdu.getBuffer();
        short lc = (short) (buffer[OFFSET_LC] & 0x00FF);
        if (lc != 2)
            ISOException.throwIt(SW_WRONG_LENGTH);
        
        apdu.setIncomingAndReceive();
        short fid = Util.getShort(buffer, OFFSET_CDATA);

        if (fileSystem.getFile(fid) == null) {
            ISOException.throwIt(ISO7816.SW_FILE_NOT_FOUND);
        }

        selectedFile = fid;
        volatileState[0] |= FILE_SELECTED;
        
        // Return NO DATA for EF selection (ICAO compliant)
        return 0;
    }

    /**
     * Process READ_BINARY - Read data from selected file
     */
    private short processReadBinary(APDU apdu, short le, boolean protectedApdu) {
        if (!hasMutuallyAuthenticated()) {
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);
        }
        
        // After BAC, secure messaging is MANDATORY
        if (hasMutuallyAuthenticated() && !protectedApdu) {
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);
        }
        
        if (!hasFileSelected()) {
            ISOException.throwIt(SW_CONDITIONS_NOT_SATISFIED);
        }

        byte[] buffer = apdu.getBuffer();
        short offset = Util.makeShort(buffer[OFFSET_P1], buffer[OFFSET_P2]);
        
        byte[] file = fileSystem.getFile(selectedFile);
        if (file == null) {
            ISOException.throwIt(ISO7816.SW_FILE_NOT_FOUND);
        }

        short fileSize = fileSystem.getFileSize(selectedFile);
        short len = (short)(fileSize - offset);
        if (len < 0) {
            ISOException.throwIt(SW_WRONG_P1P2);
        }
        
        len = PassportUtil.min(len, le);
        len = PassportUtil.min(len, (short)(buffer.length - 37));

        short bufferOffset = crypto.getApduBufferOffset(len);
        Util.arrayCopyNonAtomic(file, offset, buffer, bufferOffset, len);

        return len;
    }

    /**
     * Process UPDATE_BINARY - Write data to selected file
     */
    private void processUpdateBinary(APDU apdu, boolean protectedApdu) {
        if (!hasFileSelected() || isLocked()) {
            ISOException.throwIt(SW_CONDITIONS_NOT_SATISFIED);
        }
        
        if (hasMutuallyAuthenticated() && !protectedApdu) {
            ISOException.throwIt(SW_SECURITY_STATUS_NOT_SATISFIED);
        }

        byte[] buffer = apdu.getBuffer();
        short offset = Util.makeShort(buffer[OFFSET_P1], buffer[OFFSET_P2]);
        short readCount = apdu.setIncomingAndReceive();

        while (readCount > 0) {
            fileSystem.writeData(selectedFile, offset, buffer, OFFSET_CDATA, readCount);
            offset += readCount;
            readCount = apdu.receiveBytes(ISO7816.OFFSET_CDATA);
        }
    }

    /**
     * Process PUT_DATA - Personalization and locking
     */
    private void processPutData(APDU apdu) {
        if (isLocked()) {
            ISOException.throwIt(SW_CONDITIONS_NOT_SATISFIED);
        }

        byte[] buffer = apdu.getBuffer();
        short lc = (short) (buffer[OFFSET_LC] & 0xff);
        short p1 = (short) (buffer[OFFSET_P1] & 0xff);
        short p2 = (short) (buffer[OFFSET_P2] & 0xff);
        
        if (apdu.getCurrentState() == APDU.STATE_INITIAL) {
            apdu.setIncomingAndReceive();
        }

        // Lock command
        if (p1 == 0xDE && p2 == 0xAD) {
            persistentState |= LOCKED;
            return;
        }
        
        // MRZ data for BAC key derivation
        if (p1 == 0 && p2 == MRZ_TAG) {
            short buffer_p = OFFSET_CDATA;
            
            // Parse MRZ data
            buffer_p = BERTLVScanner.readTag(buffer, buffer_p);
            buffer_p = BERTLVScanner.readLength(buffer, buffer_p);
            buffer_p = BERTLVScanner.readTag(buffer, buffer_p);
            short docNrOffset = BERTLVScanner.readLength(buffer, buffer_p);
            short docNrLength = BERTLVScanner.valueLength;
            buffer_p = BERTLVScanner.skipValue();
            buffer_p = BERTLVScanner.readTag(buffer, buffer_p);
            short dobOffset = BERTLVScanner.readLength(buffer, buffer_p);
            short dobLength = BERTLVScanner.valueLength;
            buffer_p = BERTLVScanner.skipValue();
            buffer_p = BERTLVScanner.readTag(buffer, buffer_p);
            short doeOffset = BERTLVScanner.readLength(buffer, buffer_p);
            short doeLength = BERTLVScanner.valueLength;

            // Compute BAC key seed
            short keySeed_offset = init.computeKeySeed(buffer, docNrOffset,
                    docNrLength, dobOffset, dobLength, doeOffset, doeLength);

            // Derive and store BAC keys
            short macKey_p = (short) (keySeed_offset + KEYMATERIAL_LENGTH);
            short encKey_p = (short) (keySeed_offset + KEYMATERIAL_LENGTH + KEY_LENGTH);
            crypto.deriveKey(buffer, keySeed_offset, KEYMATERIAL_LENGTH, 
                    PassportCrypto.MAC_MODE, macKey_p);
            crypto.deriveKey(buffer, keySeed_offset, KEYMATERIAL_LENGTH, 
                    PassportCrypto.ENC_MODE, encKey_p);
            keyStore.setMutualAuthenticationKeys(buffer, macKey_p, buffer, encKey_p);
            
            persistentState |= HAS_MUTUALAUTHENTICATION_KEYS;
            return;
        }
        
        ISOException.throwIt(SW_INCORRECT_P1P2);
    }

    // State checking helper methods
    public static boolean hasMutualAuthenticationKeys() {
        return (persistentState & HAS_MUTUALAUTHENTICATION_KEYS) == HAS_MUTUALAUTHENTICATION_KEYS;
    }
    
    public static void setNoFileSelected() {
        if (hasFileSelected()) {
            volatileState[0] ^= FILE_SELECTED;
        }
    }

    public static void setNoChallenged() {
        if (isChallenged()) {
            volatileState[0] ^= CHALLENGED;
        }
    }

    public static boolean hasFileSelected() {
        return (volatileState[0] & FILE_SELECTED) == FILE_SELECTED;
    }

    public static boolean isLocked() {
        return (persistentState & LOCKED) == LOCKED;
    }

    public static boolean isChallenged() {
        return (volatileState[0] & CHALLENGED) == CHALLENGED;
    }

    public static boolean hasMutuallyAuthenticated() {
        return (volatileState[0] & MUTUAL_AUTHENTICATED) == MUTUAL_AUTHENTICATED;
    }

    /**
     * Inner class: Simplified FileSystem with pre-created files
     */
    private static class FileSystem {
        // File identifiers as per ICAO 9303
        static final short EF_COM_FID = (short) 0x011E;
        static final short EF_DG1_FID = (short) 0x0101;
        static final short EF_DG2_FID = (short) 0x0102;
        static final short EF_SOD_FID = (short) 0x011D;
        
        // Internal array indices
        private static final short MAX_FILES = 4;
        private static final short EF_COM_INDEX = 0;
        private static final short EF_DG1_INDEX = 1;
        private static final short EF_DG2_INDEX = 2;
        private static final short EF_SOD_INDEX = 3;
        
        private Object[] files;
        private short[] fileSizes;
        
        /**
         * Constructor - initializes file storage arrays
         */
        public FileSystem() {
            files = new Object[MAX_FILES];
            fileSizes = new short[MAX_FILES];
        }
        
        /**
         * Initialize files with standard sizes
         */
        public void initializeFiles() {
            // Pre-create standard e-passport files
            files[EF_COM_INDEX] = new byte[EF_COM_SIZE];
            fileSizes[EF_COM_INDEX] = EF_COM_SIZE;
            
            files[EF_DG1_INDEX] = new byte[EF_DG1_SIZE];
            fileSizes[EF_DG1_INDEX] = EF_DG1_SIZE;
            
            files[EF_DG2_INDEX] = new byte[EF_DG2_SIZE];
            fileSizes[EF_DG2_INDEX] = EF_DG2_SIZE;
            
            files[EF_SOD_INDEX] = new byte[EF_SOD_SIZE];
            fileSizes[EF_SOD_INDEX] = EF_SOD_SIZE;
        }
        
        /**
         * Write data to a file
         */
        public void writeData(short fid, short file_offset, byte[] data,
                short data_offset, short length) {
            byte[] file = getFile(fid);
            short fileSize = getFileSize(fid);
            
            if (file == null) {
                ISOException.throwIt(ISO7816.SW_FILE_NOT_FOUND);
            }
            
            if (fileSize < (short) (file_offset + length)) {
                ISOException.throwIt(ISO7816.SW_FILE_FULL);
            }
            
            Util.arrayCopy(data, data_offset, file, file_offset, length);
        }
        
        /**
         * Get file data array
         */
        public byte[] getFile(short fid) {
            short idx = getFileIndex(fid);
            if (idx == -1) {
                return null;
            }
            return (byte[]) files[idx];
        }
        
        /**
         * Get file size
         */
        public short getFileSize(short fid) {
            short idx = getFileIndex(fid);
            if (idx == -1) {
                return -1;
            }
            return fileSizes[idx];
        }
        
        /**
         * Map file identifier to array index
         */
        private static short getFileIndex(short fid) {
            switch (fid) {
                case EF_COM_FID:
                    return EF_COM_INDEX;
                case EF_DG1_FID:
                    return EF_DG1_INDEX;
                case EF_DG2_FID:
                    return EF_DG2_INDEX;
                case EF_SOD_FID:
                    return EF_SOD_INDEX;
                default:
                    return -1;
            }
        }
    }
}
