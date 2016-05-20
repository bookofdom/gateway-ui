`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Push Channel - Update',
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

test 'user can navigate to push channels edit route', (assert) ->
  visit '/push/push-channels'
  click '.ap-table-model tbody tr:eq(0) [data-t="actions.edit"] a'
  andThen ->
    assert.equal currentURL(), '/push/push-channels/1/edit'

test 'user can edit push channels', (assert) ->
  visit '/push/push-channels/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/push/push-channels/1/edit'
    assert.equal server.db.pushChannels[0].name, 'Test'
