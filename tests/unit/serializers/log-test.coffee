`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'log', 'Unit | Serializer | log',
  needs: [
    'serializer:api'
    'serializer:log'
    'serializer:proxy-endpoint'
    'model:api'
    'model:log'
    'model:endpoint-group'
    'model:environment'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-route'
    'model:proxy-endpoint-schema'
    'model:proxy-endpoint-test'
    'model:remote-endpoint'
    'model:shared-component'
  ]
  beforeEach: ->
    @server = new Pretender ->
      @get '/logs', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify logs: "127.0.0.1 captain kirk"
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().query('log', {}).then (logs) ->
    assert.ok logs
