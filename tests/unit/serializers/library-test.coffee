`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'library', 'Unit | Serializer | library',
  needs: [
    'serializer:api'
    'serializer:library'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:host'
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
      @get '/apis/1/libraries', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify libraries: [
          api_id: 1
          id: 1
          name: 'Authentication Credentials'
          description: ''
          data: 'var mock_authorization = ...'
        ,
          api_id: 1
          id: 2
          name: 'Data Variables'
          description: 'These are variables that hold static data.'
          data: 'var news_response_data = ...'
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('libraries').then (libraries) ->
      assert.equal libraries.get('length'), 2
