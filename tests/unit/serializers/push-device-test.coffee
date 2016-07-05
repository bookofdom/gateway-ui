`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'push-device', 'Unit | Serializer | push device',
  needs: [
    'serializer:push-device'
    'model:push-device'
  ]
  beforeEach: ->
    @server = new Pretender ->
      @get '/push-devices', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify push_devices: [
          id: 1
          push_channel_id: 1
          name: 'test'
          type: 'test'
          token: 'B9CE9E973D135E429338D733A4142E1E8DCCA829475565025214823AB12CCD3C'
          expires: 1494451802
        ,
          id: 2
          push_channel_id: 1
          name: 'test-gcm'
          type: 'test-gcm'
          token: 'cqvkjqoUL9A:APA91bEFS9knUbRH_X9_4UzuCdIpUp7iXQUCvmQ8zf1OepQBOEpPKkDNkjslVIqiehRN8WVi2R3hyUmK5FZ14qHMMkPQBq1pEPH2aokuFk4jAIwPEiQSCj-Ywu9bNVoGrl-ZXMjeqzPw'
          expires: 1492805093
        ]
      ]

    afterEach: ->
      @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('push-device').then (push_devices) ->
    assert.equal push_devices.get('length'), 2
