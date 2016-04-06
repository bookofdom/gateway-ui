`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'host', 'Unit | Serializer | host',
  needs: [
    'serializer:api'
    'serializer:host'
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
      @get '/apis/1/hosts', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify hosts: [
          api_id: 1
          id: 1
          name: 'fruits.apples'
          hostname: 'fruits.apples'
        ,
          api_id: 1
          id: 2
          name: 'localhost development'
          hostname: 'localhost.dev'
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('hosts').then (hosts) ->
      assert.equal hosts.get('length'), 2
