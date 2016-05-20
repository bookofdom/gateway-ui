`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Channel - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 5).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
    server.createList('push_channel', 5).forEach (channel) ->
      server.createList('push_device', 5, pushChannelId: channel.id).forEach (device) ->
        server.createList 'push_message', 5, pushDeviceId: device.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can view push channels', (assert) ->
  visit '/push/push-channels'
  andThen ->
    count = server.db.pushChannels.length
    assert.equal currentURL(), '/push/push-channels'
    assert.equal count > 0, true
    assert.equal find('.ap-table-model tbody tr').length, count
