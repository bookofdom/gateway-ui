`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'endpoint-group', 'Unit | Serializer | endpoint-group',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
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
      @get '/apis/1/endpoint_groups', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify endpoint_groups: [
          api_id: 1
          id: 1
          name: 'Event Calls'
          description: ''
        ,
          api_id: 1
          id: 2
          name: 'Hello World'
          description: 'Simple Hello World examples'
        ,
          api_id: 1
          id: 3
          name: 'JS Proxies'
          description: ''
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('endpoint_groups').then (endpoint_groups) ->
      assert.equal endpoint_groups.get('length'), 3
