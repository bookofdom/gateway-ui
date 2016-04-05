`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

server = null

moduleForModel 'environment', 'Unit | Serializer | environment', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:environment'
    'model:api'
    'model:environment-variable'
  ]

  beforeEach: ->
    server = new Pretender (->
      @get '/apis', ->
        response = {
          "apis": [
            {
              "id": 261,
              "name": "Apples",
              "description": "",
              "cors_allow_origin": "*",
              "cors_allow_headers": "content-type, accept",
              "cors_allow_credentials": true,
              "cors_request_headers": "*",
              "cors_max_age": 600,
              "enable_swagger": true,
              "base_url": "https://weary-pail-6089.justapis.io"
            },
            {
              "id": 262,
              "name": "Oranges",
              "description": "",
              "cors_allow_origin": "*",
              "cors_allow_headers": "content-type, accept",
              "cors_allow_credentials": true,
              "cors_request_headers": "*",
              "cors_max_age": 600,
              "enable_swagger": true,
              "base_url": "https://cooing-yarn-2471.justapis.io"
            },
            {
              "id": 260,
              "name": "Samples",
              "description": "",
              "cors_allow_origin": "*",
              "cors_allow_headers": "content-type, accept",
              "cors_allow_credentials": true,
              "cors_request_headers": "*",
              "cors_max_age": 600,
              "enable_swagger": false,
              "base_url": "https://miscreant-condition-9199.justapis.io"
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

  @store().findAll('api').then (apis) ->
    assert.equal apis.get('length'), 3
    return
