app:
  description: 专业定位 我是专门针对Java Card智能卡开发的技术研究助手，精通ISO 7816标准、GlobalPlatform规范以及各类智能卡应用开发。基于深度的技术文档库，提供从入门到精通的全方位支持。
    核心能力 错误诊断专家：深入分析6F00、6A82等常见错误，提供详细解决方案 APDU命令解析：精确解读命令结构，优化通信流程 安全机制顾问：BAC+SM、密钥管理、安全通道建立
    代码优化大师：内存管理、事务处理、性能调优 e-Passport专家：完整的电子护照实现方案 知识库覆盖 Sun Microsystems官方开发指南 Erik
    Poll教授的现代JavaCard教程 实战项目源码与个人化脚本 开源社区最佳实践 让我成为您的JavaCard开发伙伴，一起攻克智能卡开发的每一个难关！
  icon: dizzy
  icon_background: '#D5D9EB'
  mode: advanced-chat
  name: 高水准的Java card专家
  use_icon_as_answer_icon: false
dependencies:
- current_identifier: null
  type: marketplace
  value:
    marketplace_plugin_unique_identifier: langgenius/openai:0.0.26@c1e643ac6a7732f6333a783320b4d3026fa5e31d8e7026375b98d44418d33f26
- current_identifier: null
  type: marketplace
  value:
    marketplace_plugin_unique_identifier: langgenius/cohere:0.0.8@1456818eb78f25c1a25e91809cecbd78e5523d39868dcb78607e625913b5e4fe
kind: app
version: 0.3.0
workflow:
  conversation_variables: []
  environment_variables: []
  features:
    file_upload:
      allowed_file_extensions:
      - .JPG
      - .JPEG
      - .PNG
      - .GIF
      - .WEBP
      - .SVG
      allowed_file_types:
      - image
      allowed_file_upload_methods:
      - local_file
      - remote_url
      enabled: false
      fileUploadConfig:
        audio_file_size_limit: 50
        batch_count_limit: 5
        file_size_limit: 15
        image_file_size_limit: 10
        video_file_size_limit: 100
        workflow_file_upload_limit: 10
      image:
        enabled: false
        number_limits: 3
        transfer_methods:
        - local_file
        - remote_url
      number_limits: 3
    opening_statement: ''
    retriever_resource:
      enabled: true
    sensitive_word_avoidance:
      enabled: false
    speech_to_text:
      enabled: false
    suggested_questions: []
    suggested_questions_after_answer:
      enabled: false
    text_to_speech:
      enabled: false
      language: ''
      voice: ''
  graph:
    edges:
    - data:
        isInIteration: false
        isInLoop: false
        sourceType: llm
        targetType: answer
      id: 1744720209717-source-1744722384159-target
      selected: false
      source: '1744720209717'
      sourceHandle: source
      target: '1744722384159'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        sourceType: llm
        targetType: answer
      id: 1744719065863-source-1744739584366-target
      selected: false
      source: '1744719065863'
      sourceHandle: source
      target: '1744739584366'
      targetHandle: target
      type: custom
      zIndex: 1002
    - data:
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        sourceType: answer
        targetType: agent
      id: 1744739584366-source-1744718432075-target
      selected: false
      source: '1744739584366'
      sourceHandle: source
      target: '1744718432075'
      targetHandle: target
      type: custom
      zIndex: 1002
    - data:
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        sourceType: loop-start
        targetType: llm
      id: 1742819137183start-source-1744719065863-target
      selected: false
      source: 1742819137183start
      sourceHandle: source
      target: '1744719065863'
      targetHandle: target
      type: custom
      zIndex: 1002
    - data:
        isInLoop: false
        sourceType: loop
        targetType: llm
      id: 1742819137183-source-1744720209717-target
      selected: false
      source: '1742819137183'
      sourceHandle: source
      target: '1744720209717'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInLoop: false
        sourceType: knowledge-retrieval
        targetType: loop
      id: 1750157453647-source-1742819137183-target
      selected: false
      source: '1750157453647'
      sourceHandle: source
      target: '1742819137183'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInLoop: false
        sourceType: answer
        targetType: llm
      id: 1742796603242-source-1744720209717-target
      selected: false
      source: '1742796603242'
      sourceHandle: source
      target: '1744720209717'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: false
        sourceType: start
        targetType: answer
      id: 1742554928243-source-1750175242488-target
      source: '1742554928243'
      sourceHandle: source
      target: '1750175242488'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: false
        sourceType: answer
        targetType: answer
      id: 1750175242488-source-1742796603242-target
      source: '1750175242488'
      sourceHandle: source
      target: '1742796603242'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: false
        sourceType: start
        targetType: llm
      id: 1742554928243-source-1750175385983-target
      source: '1742554928243'
      sourceHandle: source
      target: '1750175385983'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: false
        sourceType: llm
        targetType: knowledge-retrieval
      id: 1750175385983-source-1750157453647-target
      source: '1750175385983'
      sourceHandle: source
      target: '1750157453647'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        sourceType: agent
        targetType: llm
      id: 1744718432075-source-1750175571935-target
      source: '1744718432075'
      sourceHandle: source
      target: '1750175571935'
      targetHandle: target
      type: custom
      zIndex: 1002
    - data:
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        sourceType: llm
        targetType: assigner
      id: 1750175571935-source-1744719657666-target
      source: '1750175571935'
      sourceHandle: source
      target: '1744719657666'
      targetHandle: target
      type: custom
      zIndex: 1002
    nodes:
    - data:
        desc: ''
        selected: false
        title: user input
        type: start
        variables:
        - label: research_topic
          max_length: 256
          options: []
          required: true
          type: text-input
          variable: research_topic
        - label: max_loop
          max_length: 48
          options: []
          required: true
          type: number
          variable: max_loop
      height: 143
      id: '1742554928243'
      position:
        x: -978.8664387007439
        y: 800.1980683428504
      positionAbsolute:
        x: -978.8664387007439
        y: 800.1980683428504
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: '# 🔍 研究意图分析


          根据用户输入 "{{user_input}}"，我理解您想要研究：


          **研究主题**：{{research_topic}}{{#1742554928243.research_topic#}}


          ## 📋 研究计划：

          1. **信息收集阶段**：搜索相关的基础信息、定义和概念

          2. **深入分析阶段**：探索技术细节、实现方法和最佳实践

          3. **案例研究阶段**：查找实际应用案例和成功经验

          4. **总结整合阶段**：综合所有发现，形成完整的知识体系


          ## 🚀 开始研究流程...

          正在为您启动智能研究助手，请稍候...

          '
        desc: ''
        selected: false
        title: 'Intent analysis stream output '
        type: answer
        variables: []
      height: 423
      id: '1742796603242'
      position:
        x: -263.8302772132594
        y: 535.5572272121415
      positionAbsolute:
        x: -263.8302772132594
        y: 535.5572272121415
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        break_conditions:
        - comparison_operator: ≥
          id: f77ef33a-4da3-48cb-8e9e-20aad67a8f7f
          numberVarType: constant
          value: '3'
          varType: number
          variable_selector:
          - '1742819137183'
          - current_loop
        desc: ''
        error_handle_mode: terminated
        height: 565
        logical_operator: and
        loop_count: 50
        loop_variables:
        - id: 571b3fa9-99b9-481f-9355-8a95618394e9
          label: findings
          value: '[]'
          value_type: constant
          var_type: array[string]
        - id: be149194-f806-4fa4-8a6e-a546c1b65941
          label: executed_queries
          value: '[]'
          value_type: constant
          var_type: array[string]
        - id: 4b5be6c3-90df-4dc1-bf98-732e9b589054
          label: visitedURLs
          value: '[]'
          value_type: constant
          var_type: array[string]
        selected: false
        start_node_id: 1742819137183start
        title: loop
        type: loop
        width: 1327.9999997219938
      height: 565
      id: '1742819137183'
      position:
        x: 69.23792025453054
        y: 800.1980683428504
      positionAbsolute:
        x: 69.23792025453054
        y: 800.1980683428504
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 1328
      zIndex: 1
    - data:
        desc: ''
        isInLoop: true
        selected: false
        title: ''
        type: loop-start
      draggable: false
      height: 60
      id: 1742819137183start
      parentId: '1742819137183'
      position:
        x: 24
        y: 68
      positionAbsolute:
        x: 93.23792025453054
        y: 868.1980683428504
      selectable: false
      sourcePosition: right
      targetPosition: left
      type: custom-loop-start
      width: 55
      zIndex: 1002
    - data:
        agent_parameters:
          instruction:
            type: constant
            value: ''
          maximum_iterations:
            type: constant
            value: 5
          model:
            type: constant
            value:
              completion_params: {}
              mode: chat
              model: o1
              model_type: llm
              provider: langgenius/openai/openai
              type: model-selector
          query:
            type: constant
            value: ''
          tools:
            type: constant
            value:
            - enabled: true
              extra:
                description: 专为人工智能代理 (LLM) 构建的搜索引擎工具，可快速提供实时、准确和真实的结果。
              parameters:
                days:
                  auto: 1
                  value: null
                query:
                  auto: 1
                  value: null
                search_depth:
                  auto: 1
                  value: null
                time_range:
                  auto: 1
                  value: null
                topic:
                  auto: 1
                  value: null
              provider_name: langgenius/tavily/tavily
              schemas:
              - auto_generate: null
                default: null
                form: llm
                human_description:
                  en_US: The search query you want to execute with Tavily.
                  ja_JP: The search query you want to execute with Tavily.
                  pt_BR: The search query you want to execute with Tavily.
                  zh_Hans: 您想用 Tavily 执行的搜索查询。
                label:
                  en_US: Query
                  ja_JP: Query
                  pt_BR: Query
                  zh_Hans: 查询
                llm_description: The search query.
                max: null
                min: null
                name: query
                options: []
                placeholder: null
                precision: null
                required: true
                scope: null
                template: null
                type: string
              - auto_generate: null
                default: basic
                form: llm
                human_description:
                  en_US: The depth of the search.
                  ja_JP: The depth of the search.
                  pt_BR: The depth of the search.
                  zh_Hans: 搜索的深度。
                label:
                  en_US: Search Depth
                  ja_JP: Search Depth
                  pt_BR: Search Depth
                  zh_Hans: 搜索深度
                llm_description: The depth of the search. 'basic' for standard search,
                  'advanced' for more comprehensive results.
                max: null
                min: null
                name: search_depth
                options:
                - label:
                    en_US: Basic
                    ja_JP: Basic
                    pt_BR: Basic
                    zh_Hans: 基本
                  value: basic
                - label:
                    en_US: Advanced
                    ja_JP: Advanced
                    pt_BR: Advanced
                    zh_Hans: 高级
                  value: advanced
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: select
              - auto_generate: null
                default: general
                form: llm
                human_description:
                  en_US: The category of the search.
                  ja_JP: The category of the search.
                  pt_BR: The category of the search.
                  zh_Hans: 搜索的类别。
                label:
                  en_US: Topic
                  ja_JP: Topic
                  pt_BR: Topic
                  zh_Hans: 主题
                llm_description: The category of the search. Options include 'general',
                  'news', or 'finance'.
                max: null
                min: null
                name: topic
                options:
                - label:
                    en_US: General
                    ja_JP: General
                    pt_BR: General
                    zh_Hans: 一般
                  value: general
                - label:
                    en_US: News
                    ja_JP: News
                    pt_BR: News
                    zh_Hans: 新闻
                  value: news
                - label:
                    en_US: Finance
                    ja_JP: Finance
                    pt_BR: Finance
                    zh_Hans: 金融
                  value: finance
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: select
              - auto_generate: null
                default: 3
                form: llm
                human_description:
                  en_US: The number of days back from the current date to include
                    in the search results (only applicable when "topic" is "news").
                  ja_JP: The number of days back from the current date to include
                    in the search results (only applicable when "topic" is "news").
                  pt_BR: The number of days back from the current date to include
                    in the search results (only applicable when "topic" is "news").
                  zh_Hans: 从当前日期起向前追溯的天数，以包含在搜索结果中（仅当"topic"为"news"时适用）。
                label:
                  en_US: Days
                  ja_JP: Days
                  pt_BR: Days
                  zh_Hans: 天数
                llm_description: The number of days back from the current date to
                  include in the search results. Only applicable when "topic" is "news".
                max: null
                min: 1
                name: days
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: number
              - auto_generate: null
                default: not_specified
                form: llm
                human_description:
                  en_US: The time range back from the current date to filter results.
                  ja_JP: The time range back from the current date to filter results.
                  pt_BR: The time range back from the current date to filter results.
                  zh_Hans: 从当前日期起向后筛选结果的时间范围。
                label:
                  en_US: Time Range
                  ja_JP: Time Range
                  pt_BR: Time Range
                  zh_Hans: 时间范围
                llm_description: The time range back from the current date to filter
                  results. Options include 'not_specified', 'day', 'week', 'month',
                  or 'year'.
                max: null
                min: null
                name: time_range
                options:
                - label:
                    en_US: Not Specified
                    ja_JP: Not Specified
                    pt_BR: Not Specified
                    zh_Hans: 不指定
                  value: not_specified
                - label:
                    en_US: Day
                    ja_JP: Day
                    pt_BR: Day
                    zh_Hans: 天
                  value: day
                - label:
                    en_US: Week
                    ja_JP: Week
                    pt_BR: Week
                    zh_Hans: 周
                  value: week
                - label:
                    en_US: Month
                    ja_JP: Month
                    pt_BR: Month
                    zh_Hans: 月
                  value: month
                - label:
                    en_US: Year
                    ja_JP: Year
                    pt_BR: Year
                    zh_Hans: 年
                  value: year
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: select
              - auto_generate: null
                default: 5
                form: form
                human_description:
                  en_US: The maximum number of search results to return.
                  ja_JP: The maximum number of search results to return.
                  pt_BR: The maximum number of search results to return.
                  zh_Hans: 要返回的最大搜索结果数。
                label:
                  en_US: Max Results
                  ja_JP: Max Results
                  pt_BR: Max Results
                  zh_Hans: 最大结果数
                llm_description: The maximum number of search results to return. Range
                  is 1-20.
                max: 20
                min: 1
                name: max_results
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: number
              - auto_generate: null
                default: 0
                form: form
                human_description:
                  en_US: Include a list of query-related images in the response.
                  ja_JP: Include a list of query-related images in the response.
                  pt_BR: Include a list of query-related images in the response.
                  zh_Hans: 在响应中包含与查询相关的图片列表。
                label:
                  en_US: Include Images
                  ja_JP: Include Images
                  pt_BR: Include Images
                  zh_Hans: 包含图片
                llm_description: When set to true, includes a list of query-related
                  images in the response.
                max: null
                min: null
                name: include_images
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: boolean
              - auto_generate: null
                default: 0
                form: form
                human_description:
                  en_US: When include_images is True, adds descriptive text for each
                    image.
                  ja_JP: When include_images is True, adds descriptive text for each
                    image.
                  pt_BR: When include_images is True, adds descriptive text for each
                    image.
                  zh_Hans: 当 include_images 为 True 时，为每个图像添加描述文本。
                label:
                  en_US: Include Image Descriptions
                  ja_JP: Include Image Descriptions
                  pt_BR: Include Image Descriptions
                  zh_Hans: 包含图片描述
                llm_description: When include_images is True and this is set to true,
                  adds descriptive text for each image.
                max: null
                min: null
                name: include_image_descriptions
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: boolean
              - auto_generate: null
                default: 0
                form: form
                human_description:
                  en_US: Include a short answer to the original query in the response.
                  ja_JP: Include a short answer to the original query in the response.
                  pt_BR: Include a short answer to the original query in the response.
                  zh_Hans: 在响应中包含对原始查询的简短回答。
                label:
                  en_US: Include Answer
                  ja_JP: Include Answer
                  pt_BR: Include Answer
                  zh_Hans: 包含答案
                llm_description: When set to true, includes a short answer to the
                  original query in the response.
                max: null
                min: null
                name: include_answer
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: boolean
              - auto_generate: null
                default: 0
                form: form
                human_description:
                  en_US: Include the cleaned and parsed HTML content of each search
                    result.
                  ja_JP: Include the cleaned and parsed HTML content of each search
                    result.
                  pt_BR: Include the cleaned and parsed HTML content of each search
                    result.
                  zh_Hans: 包含每个搜索结果的已清理和解析的HTML内容。
                label:
                  en_US: Include Raw Content
                  ja_JP: Include Raw Content
                  pt_BR: Include Raw Content
                  zh_Hans: 包含原始内容
                llm_description: When set to true, includes the cleaned and parsed
                  HTML content of each search result.
                max: null
                min: null
                name: include_raw_content
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: boolean
              - auto_generate: null
                default: null
                form: form
                human_description:
                  en_US: A comma-separated list of domains to specifically include
                    in the search results.
                  ja_JP: A comma-separated list of domains to specifically include
                    in the search results.
                  pt_BR: A comma-separated list of domains to specifically include
                    in the search results.
                  zh_Hans: 要在搜索结果中特别包含的域的逗号分隔列表。
                label:
                  en_US: Include Domains
                  ja_JP: Include Domains
                  pt_BR: Include Domains
                  zh_Hans: 包含域
                llm_description: A comma-separated list of domains to specifically
                  include in the search results.
                max: null
                min: null
                name: include_domains
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: string
              - auto_generate: null
                default: null
                form: form
                human_description:
                  en_US: A comma-separated list of domains to specifically exclude
                    from the search results.
                  ja_JP: A comma-separated list of domains to specifically exclude
                    from the search results.
                  pt_BR: A comma-separated list of domains to specifically exclude
                    from the search results.
                  zh_Hans: 要从搜索结果中特别排除的域的逗号分隔列表。
                label:
                  en_US: Exclude Domains
                  ja_JP: Exclude Domains
                  pt_BR: Exclude Domains
                  zh_Hans: 排除域
                llm_description: A comma-separated list of domains to specifically
                  exclude from the search results.
                max: null
                min: null
                name: exclude_domains
                options: []
                placeholder: null
                precision: null
                required: false
                scope: null
                template: null
                type: string
              settings:
                exclude_domains:
                  value: null
                include_answer:
                  value: 0
                include_domains:
                  value: null
                include_image_descriptions:
                  value: 0
                include_images:
                  value: 0
                include_raw_content:
                  value: 0
                max_results:
                  value: 5
              tool_description: 专为人工智能代理 (LLM) 构建的搜索引擎工具，可快速提供实时、准确和真实的结果。
              tool_label: Tavily Search
              tool_name: tavily_search
              type: builtin
            - enabled: true
              extra:
                description: 一个用于根据提供的文档名称和主题，在DevDocs中搜索特定主题和路径的工具。不要忘记在系统提示词中添加一些示例；例如，文档名称应该是\"vuex~4\"、\"css\"或\"python~3.12\"，而主题应该是\"guide/actions\"用于Vuex
                  4，\"display-box\"用于CSS，或\"library/code\"用于Python 3.12。
              parameters:
                doc:
                  auto: 1
                  value: null
                topic:
                  auto: 1
                  value: null
              provider_name: langgenius/devdocs/devdocs
              schemas:
              - auto_generate: null
                default: null
                form: llm
                human_description:
                  en_US: The name of the documentation.
                  ja_JP: The name of the documentation.
                  pt_BR: The name of the documentation.
                  zh_Hans: 文档名称。
                label:
                  en_US: Documentation name
                  ja_JP: Documentation name
                  pt_BR: Documentation name
                  zh_Hans: 文档名称
                llm_description: The name of the documentation, such as \"vuex~4\",
                  \"css\", or \"python~3.12\". The exact value should be identified
                  by the user.
                max: null
                min: null
                name: doc
                options: []
                placeholder: null
                precision: null
                required: true
                scope: null
                template: null
                type: string
              - auto_generate: null
                default: null
                form: llm
                human_description:
                  en_US: The path of the section/topic.
                  ja_JP: The path of the section/topic.
                  pt_BR: The path of the section/topic.
                  zh_Hans: 文档主题的路径。
                label:
                  en_US: Topic name
                  ja_JP: Topic name
                  pt_BR: Topic name
                  zh_Hans: 主题名称
                llm_description: The path of the section/topic, such as \"guide/actions\"
                  for Vuex 4, \"display-box\" for CSS, or \"library/code\" for Python
                  3.12.
                max: null
                min: null
                name: topic
                options: []
                placeholder: null
                precision: null
                required: true
                scope: null
                template: null
                type: string
              settings: {}
              tool_description: 一个用于根据提供的文档名称和主题，在DevDocs中搜索特定主题和路径的工具。不要忘记在系统提示词中添加一些示例；例如，文档名称应该是\"vuex~4\"、\"css\"或\"python~3.12\"，而主题应该是\"guide/actions\"用于Vuex
                4，\"display-box\"用于CSS，或\"library/code\"用于Python 3.12。
              tool_label: 搜索开发者文档
              tool_name: searchDevDocs
              type: builtin
        agent_strategy_label: ReAct
        agent_strategy_name: ReAct
        agent_strategy_provider_name: langgenius/agent/agent
        desc: ''
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        output_schema: null
        plugin_unique_identifier: langgenius/agent:0.0.15@89d496aa9b23fcd1ef9add8cfcbadeaeb4eb5c30ff8d76f7e6c9d59c46d2e2f5
        selected: false
        title: Act
        type: agent
      height: 235
      id: '1744718432075'
      parentId: '1742819137183'
      position:
        x: 561.3333401290374
        y: 275.33333333333303
      positionAbsolute:
        x: 630.571260383568
        y: 1075.5314016761836
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
      zIndex: 1002
    - data:
        context:
          enabled: false
          variable_selector: []
        desc: ''
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        model:
          completion_params: {}
          mode: chat
          name: o1
          provider: langgenius/openai/openai
        prompt_template:
        - id: 44840411-088b-473d-8186-d0d815707e30
          role: system
          text: '你是一位世界一流的研究员。 你的任务是基于研究目标和已有的发现，生成下一步的搜索查询。 请分析以下信息： - 研究目标: {{user_input.research_topic}}{{#1742554928243.research_topic#}}
            - 已有发现: {{loop.findings}} {{#1742819137183.findings#}}- 已执行的查询: {{loop.executed_queries}}{{#1742819137183.executed_queries#}} '
        selected: false
        structured_output:
          schema:
            additionalProperties: false
            properties:
              knowledge_gaps:
                description: Information that is needed to answer the original question,
                  but not yet obtained
                type: string
              reasoning:
                description: Detail why you chose this search_query
                type: string
              search_query:
                description: 'Further research into the follow-up question on the
                  topic, which is the only one that is a good query keyword for getting
                  SERPs '
                type: string
            required:
            - reasoning
            - search_query
            - knowledge_gaps
            type: object
        structured_output_enabled: true
        title: reasoning
        type: llm
        variables: []
        vision:
          enabled: false
      height: 111
      id: '1744719065863'
      parentId: '1742819137183'
      position:
        x: 57.3333333333332
        y: 274.3333333333335
      positionAbsolute:
        x: 126.57125358786374
        y: 1074.531401676184
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
      zIndex: 1002
    - data:
        desc: ''
        isInIteration: false
        isInLoop: true
        items:
        - input_type: variable
          operation: append
          value:
          - '1744719065863'
          - structured_output
          - search_query
          variable_selector:
          - '1742819137183'
          - executed_queries
          write_mode: over-write
        - input_type: variable
          operation: append
          value:
          - '1744718432075'
          - text
          variable_selector:
          - '1742819137183'
          - findings
          write_mode: over-write
        - input_type: variable
          operation: extend
          value:
          - '1744742949280'
          - structured_output
          - urls
          variable_selector:
          - '1742819137183'
          - visitedURLs
          write_mode: over-write
        loop_id: '1742819137183'
        selected: false
        title: Variable Assigner
        type: assigner
        version: '2'
      height: 174
      id: '1744719657666'
      parentId: '1742819137183'
      position:
        x: 1068
        y: 133.00000024711642
      positionAbsolute:
        x: 1137.2379202545305
        y: 933.1980685899669
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
      zIndex: 1002
    - data:
        context:
          enabled: false
          variable_selector: []
        desc: ''
        model:
          completion_params: {}
          mode: chat
          name: o1
          provider: langgenius/openai/openai
        prompt_template:
        - id: 5374ac10-9e1e-4f6a-830c-0eb5cecbc6fc
          role: system
          text: 你是一位世界一流的研究员和报告撰写专家。 你的任务是基于给定的研究主题、所有的发现和来源链接，撰写一份最终的、全面的、客观的研究报告。
            报告必须结构清晰、易于阅读、富有洞察力。如果发现中有图片信息，请以 Markdown 链接的形式包含在报告中。请确保最终输出的文本能被前端正确解析。
        - id: 9c86a54a-9f54-4b52-9a23-720d42b520a7
          role: user
          text: '请根据以下信息，生成最终的综合研究报告： - 研究主题: {{user_input.research_topic}}{{#1742554928243.research_topic#}}
            - 研究发现汇总: {{loop.findings}}{{#1742819137183.findings#}} - 已执行的查询历史: {{loop.executed_queries}}{{#1742819137183.executed_queries#}}
            - 全部信息来源 (URLs): {{loop.visitedURLs}}{{#1742819137183.visitedURLs#}}'
        selected: false
        structured_output_enabled: false
        title: finalize_summary
        type: llm
        variables: []
        vision:
          enabled: false
      height: 111
      id: '1744720209717'
      position:
        x: 1423.4141033267188
        y: 722.7950538713332
      positionAbsolute:
        x: 1423.4141033267188
        y: 722.7950538713332
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: '{{finalize_summary.text}}{{#1744720209717.text#}}'
        desc: ''
        selected: false
        title: 'Answer '
        type: answer
        variables: []
      height: 143
      id: '1744722384159'
      position:
        x: 1713.1946562006615
        y: 722.7950538713332
      positionAbsolute:
        x: 1713.1946562006615
        y: 722.7950538713332
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: '### according to {{#1744719065863.structured_output.reasoning#}}

          <hr style="height: 1px; background-color: #ddd; border: none; margin: 15px
          0;">

          ### The current knowledge gap is ：                           {{#1744719065863.structured_output.knowledge_gaps#}}

          <hr style="height: 1px; background-color: #ddd; border: none; margin: 15px
          0;">

          ### So the next query is:{{#1744719065863.structured_output.search_query#}}'
        desc: ''
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        selected: false
        title: Answer 4
        type: answer
        variables: []
      height: 366
      id: '1744739584366'
      parentId: '1742819137183'
      position:
        x: 300.7875331135887
        y: 179
      positionAbsolute:
        x: 370.02545336811926
        y: 979.1980683428504
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
      zIndex: 1002
    - data:
        author: Dify
        desc: ''
        height: 587
        selected: false
        showAuthor: true
        text: '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"深度研究是智能体工作流程的典型场景，在该场景中，用户意图可以通过一系列步骤来理解并形式化。","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"在开始研究前补充背景信息。通过答案节点流式输出，避免用户长时间等待。","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}'
        theme: blue
        title: ''
        type: ''
        width: 583
      height: 587
      id: '1744806191843'
      position:
        x: -502.6403952669107
        y: -148.4157820051439
      positionAbsolute:
        x: -502.6403952669107
        y: -148.4157820051439
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom-note
      width: 583
    - data:
        author: Dify
        desc: ''
        height: 606
        selected: false
        showAuthor: true
        text: '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"const
          knowledge_gaps = \"\"; // 知识差距","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"const
          findings = []; //知识发现","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}'
        theme: pink
        title: ''
        type: ''
        width: 1158
      height: 606
      id: '1744806460601'
      position:
        x: 217.53969748298698
        y: -148.4157820051439
      positionAbsolute:
        x: 217.53969748298698
        y: -148.4157820051439
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom-note
      width: 1158
    - data:
        author: Dify
        desc: ''
        height: 612
        selected: false
        showAuthor: true
        text: '{"root":{"children":[{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"外层是反思循环，内层是执行循环，智能体在执行循环中针对特定子主题开展研究工作。在执行循环中，通过调用搜索/访问/思考工具的函数来获取答案。","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""},{"children":[{"detail":0,"format":0,"mode":"normal","style":"","text":"这个过程与人类研究中的
          “反思” 阶段非常相似 —— 思考 “我已经知道什么”、“我还需要知道什么” 以及 “我接下来应该查询什么”。整个系统的创新之处就在于这种迭代方法：收集信息；分析现有信息与原始问题之间的
          “差距”；生成新的查询以填补这些差距；重复这个过程，直到差距被填补。 ","type":"text","version":1},{"type":"linebreak","version":1},{"type":"linebreak","version":1},{"detail":0,"format":0,"mode":"normal","style":"","text":"这里我们简单演示了如何实现图文混排的
          deep research 通过注入外部 markdown 链接给 llm 即可，但是要实现精确引用和 keyword 生成还需要细节上的调整","type":"text","version":1}],"direction":"ltr","format":"","indent":0,"type":"paragraph","version":1,"textFormat":0,"textStyle":""}],"direction":"ltr","format":"","indent":0,"type":"root","version":1}}'
        theme: blue
        title: ''
        type: ''
        width: 667
      height: 612
      id: '1744806907836'
      position:
        x: 1539.5569858798422
        y: -214.9462985876812
      positionAbsolute:
        x: 1539.5569858798422
        y: -214.9462985876812
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom-note
      width: 667
    - data:
        dataset_ids:
        - pEounmye7KlZP6xd3z8iGA3HbRgr+YmsChwms4ego8/08FPswMjPnoU3eBaWv4RK
        - mccz5DZ23E0/cK/b93FVdCZVvoQN6kIHiVQFD7f4JAIBXSHSIJV++07MzwLZO+U6
        - 1ZJEJPTMMCM0ZH5LN/Qg2QWoOqOv64lNwvEANy2rsmW0CKWHadqltTAAo7HoTz3X
        desc: ''
        multiple_retrieval_config:
          reranking_enable: false
          reranking_mode: reranking_model
          reranking_model:
            model: rerank-multilingual-v3.0
            provider: langgenius/cohere/cohere
          score_threshold: 0.3
          top_k: 5
        query_variable_selector:
        - '1742554928243'
        - research_topic
        retrieval_mode: multiple
        selected: false
        title: 知识检索
        type: knowledge-retrieval
      height: 164
      id: '1750157453647'
      position:
        x: -263.8302772132594
        y: 995.6744604723035
      positionAbsolute:
        x: -263.8302772132594
        y: 995.6744604723035
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: ''
        desc: ''
        selected: false
        title: Get context
        type: answer
        variables: []
      height: 101
      id: '1750175242488'
      position:
        x: -626.0215336672184
        y: 583.1130569000367
      positionAbsolute:
        x: -626.0215336672184
        y: 583.1130569000367
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        context:
          enabled: false
          variable_selector: []
        desc: ''
        model:
          completion_params:
            temperature: 0.7
          mode: chat
          name: o1
          provider: langgenius/openai/openai
        prompt_template:
        - id: 55d8a491-ec3e-4932-a0f4-f7a0c41ae23c
          role: system
          text: 'topic：{{#1742554928243.research_topic#}}


            <intent-mining>

            To uncover the deepest user intent behind every query, analyze through
            these progressive layers:


            1. Surface Intent: The literal interpretation of what they''re asking
            for

            2. Practical Intent: The tangible goal or problem they''re trying to solve

            3. Shadow Intent: The unconscious motivations they themselves may not
            recognize


            Map each query through ALL these layers, especially focusing on uncovering
            Shadow Intent.

            </intent-mining>

            Then, based on the above speculation, take a step back and think to explore
            the user''s intention behind the question.'
        selected: true
        title: Intent analysis
        type: llm
        variables: []
        vision:
          enabled: false
      height: 111
      id: '1750175385983'
      position:
        x: -641.4267401620716
        y: 986.3411271389705
      positionAbsolute:
        x: -641.4267401620716
        y: 986.3411271389705
      selected: true
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        context:
          enabled: false
          variable_selector: []
        desc: ''
        isInIteration: false
        isInLoop: true
        loop_id: '1742819137183'
        model:
          completion_params:
            temperature: 0.7
          mode: chat
          name: o1
          provider: langgenius/openai/openai
        prompt_template:
        - id: 2f9ff2ca-3c38-4409-9bd3-65afb6cbfb87
          role: system
          text: You can extract the http URLs from the {{#1744718432075.text#}}
        - id: f5e23e54-fe7b-43e2-8f93-f0d33ffb503c
          role: user
          text: 'Please help me extract links from text '
        selected: false
        structured_output:
          schema:
            additionalProperties: false
            properties:
              urls:
                description: Please extract the general source link into this variable
                items:
                  type: string
                type: array
            required:
            - urls
            type: object
        structured_output_enabled: true
        title: url extract
        type: llm
        variables: []
        vision:
          enabled: false
      height: 111
      id: '1750175571935'
      parentId: '1742819137183'
      position:
        x: 814.6666663886601
        y: 221.00000024711653
      positionAbsolute:
        x: 883.9045866431907
        y: 1021.198068589967
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
      zIndex: 1002
    viewport:
      x: 358.1604437281594
      y: -379.28503121215635
      zoom: 0.8705505874979572
