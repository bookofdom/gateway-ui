`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'environment', 'Unit | Serializer | environment',
  needs: [
    'serializer:api'
    'serializer:environment'
    'model:api' # env
    'model:environment-variable' #env
    'model:endpoint-group' #api
    'model:environment' #api
    'model:host' #api
    'model:library' #api
    'model:proxy-endpoint' #api
    'model:remote-endpoint' #api
    'model:shared-component' #api
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
  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    assert.equal apis.get('length'), 1
