`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'api', 'Unit | Serializer | api',
  needs: [
    'serializer:api'
    'model:custom-function'
    'model:endpoint-group'
    'model:environment'
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
          base_url: 'https://weary-pail-6089.example.net'
        ,
          id: 2
          name: 'Oranges'
          base_url: 'https://cooing-yarn-2471.example.net'
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    assert.equal apis.get('length'), 2
