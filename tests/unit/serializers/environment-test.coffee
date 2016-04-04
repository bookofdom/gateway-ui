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
      @get '/environments', ->
        response = {
          "environments": [
            {
                "api_id": 260,
                "id": 269,
                "name": "Dev",
                "description": "dev",
                "data": {
                    "mockEventsUrl": "http://justapis-mock.herokuapp.com/v1/events/"
                },
                "session_name": "_dev_justapisamples",
                "session_auth_key": "3442345345435w",
                "session_encryption_key": "",
                "session_auth_key_rotate": "",
                "session_encryption_key_rotate": "",
                "show_javascript_errors": false
            },
            {
                "api_id": 260,
                "id": 275,
                "name": "Prod",
                "description": "prod",
                "data": {},
                "session_name": "",
                "session_auth_key": "",
                "session_encryption_key": "",
                "session_auth_key_rotate": "",
                "session_encryption_key_rotate": "",
                "show_javascript_errors": false
            },
            {
                "api_id": 260,
                "id": 274,
                "name": "Test",
                "description": "test",
                "data": {},
                "session_name": "",
                "session_auth_key": "",
                "session_encryption_key": "",
                "session_auth_key_rotate": "",
                "session_encryption_key_rotate": "",
                "show_javascript_errors": false
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
  @store().findAll('environment').then (environments) ->
    assert.equal environments.get('length'), 3
    return
