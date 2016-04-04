`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

server = null

moduleForModel 'host', 'Unit | Serializer | host', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:host'
    'model:api'
  ]

  beforeEach: ->
    server = new Pretender (->
      @get '/hosts', ->
        response = {
          "hosts": [
            {
                "api_id": 260,
                "id": 280,
                "name": "fruits.apples",
                "hostname": "fruits.apples"
            },
            {
                "api_id": 260,
                "id": 279,
                "name": "localhost development",
                "hostname": "localhost.dev"
            },
            {
                "api_id": 260,
                "id": 273,
                "name": "miscreant-condition-9199",
                "hostname": "miscreant-condition-9199.justapis.io"
            }
          ]
        }
        return [
          200
          {"Content-Type": "application/json"}
          JSON.stringify response
        ]
    )

  afterEach: ->
    server.shutdown()

}

test 'it serializes records', (assert) ->
  @store().findAll('host').then (hosts) ->
    assert.equal hosts.get('length'), 3
    return
