`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

server = null

moduleForModel 'endpoint-group', 'Unit | Serializer | endpoint-group', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:endpoint-group'
    'model:api'
  ]

  beforeEach: ->
    server = new Pretender(->
      @get '/endpoint-groups', ->
        response = {
          "endpoint_groups": [
              {
                  "api_id": 260,
                  "id": 801,
                  "name": "Event Calls",
                  "description": ""
              },
              {
                  "api_id": 260,
                  "id": 802,
                  "name": "Hello World",
                  "description": "Simple Hello World examples"
              },
              {
                  "api_id": 260,
                  "id": 803,
                  "name": "JS Proxies",
                  "description": ""
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

test 'it normalizes records', (assert) ->
  @store().findAll('endpoint-group').then (endpoint_groups) ->
    assert.equal endpoint_groups.get('length'), 3
    return
