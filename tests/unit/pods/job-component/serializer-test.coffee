`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'job-component', 'Unit | Serializer | job component',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:job'
    'serializer:job-test'
    'serializer:job-component'
    'model:api'
    'model:custom-function'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:job-component'
    'model:job-component-call'
    'model:job-component-transformation'
    'model:job-test'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:shared-component'
  ]

  beforeEach: ->
    @server = new Pretender ->
      @get '/apis', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify apis: [
          id: 1
          name: 'Apples'
        ]
      ]
      @get '/apis/1/endpoint_groups', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify endpoint_groups: [
          api_id: 1
          id: 1
          name: 'Event Calls'
        ]
      ]
      @get '/apis/1/environments', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify environments: [
          api_id: 1
          id: 1
          name: 'One'
        ]
      ]
      @get '/apis/1/jobs', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify jobs: [
          components: [
            type: 'js'
            conditional: 'var foo = ...'
            conditional_positive: true
            description: 'Excepturi illum dolores nisi libero mollitia atque odio tempora perspiciatis.'
            name: 'Inverse Component'
            proxy_endpoint_component_id: 83786
            id: 1
            proxy_endpoint_component_reference_id: '11'
          ,
            type: 'js'
            conditional: 'var foo = ...'
            data: 'console.log(\'code string\');'
            conditional_positive: false
            description: 'Possimus enim delectus esse.'
            name: 'Ameliorated Component'
            proxy_endpoint_component_id: 57707
            id: 2
            proxy_endpoint_component_reference_id: '19'
          ,
            shared_component_id: 3
            type: 'shared'
            conditional: 'var foo ...'
            data: 'console.log(\'code string\');'
            conditional_positive: false
            description: 'Molestias modi occaecati culpa officia.'
            name: 'Implemented Component'
            proxy_endpoint_component_id: 5099
            id: 3
            proxy_endpoint_component_reference_id: '20'
          ]
          endpoint_group_id: 1
          environment_id: 1
          description: 'Inventore in ad reiciendis quis et.'
          name: 'Tempora'
          id: 1
          api_id: 1
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('jobs').then (jobs) ->
      job = jobs.get('firstObject')
      job_components = job.get('components')
      assert.equal job_components.get('length'), 3
