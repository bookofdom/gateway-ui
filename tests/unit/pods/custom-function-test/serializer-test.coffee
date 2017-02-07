`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'custom-function-test', 'Unit | Serializer | custom function test',
  needs: [
    'serializer:api'
    'serializer:custom-function'
    'serializer:custom-function-test'
    'model:api'
    'model:custom-function'
    'model:custom-function-file'
    'model:custom-function-test'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
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
      @get '/apis/1/custom_functions', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify custom_functions: [
          api_id: 1
          id: 1
          name: 'test1'
          description: 'a custom function'
          active: true
          memory: 4
          cpu_shares: 2
        ,
          api_id: 1
          id: 2
          name: 'test2'
          description: 'a custom function'
          active: false
          memory: 4
          cpu_shares: 2
        ]
      ]
      @get '/apis/1/custom_functions/1/tests', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify tests: [
          custom_function_id: 1
          id: 1
          name: 'test'
          input: {}
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('custom_functions').then (customFunctions) ->
      customFunction = customFunctions.get('firstObject')
      customFunction.get('tests').then (tests) ->
        assert.equal tests.get('length'), 1
