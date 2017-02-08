`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'job-test', 'Unit | Serializer | job test',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:job'
    'serializer:job-test'
    'model:api'
    'model:custom-function'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:job-component'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:shared-component'
    'model:job-test'
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
          api_id: 1
          endpoint_group_id: 1
          environment_id: 1
          id: 1
          name: 'hello world'
        ]
      ]
      @get '/apis/1/jobs/1/tests', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify job_tests: [
          job_id: 1
          id: 1
          name: 'test'
          parameters: {}
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('jobs').then (jobs) ->
      job = jobs.get('firstObject')
      job.get('tests').then (job_tests) ->
        assert.equal job_tests.get('length'), 1
