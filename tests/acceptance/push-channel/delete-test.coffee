`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Channel - Delete',
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

test 'user can delete push channels from index route', (assert) ->
  visit '/manage/push/channels'
  andThen ->
    assert.equal currentURL(), '/manage/push/channels'
    assert.equal server.db.pushChannels.length, 5
    assert.equal find('.ap-table-auto-index tbody tr').length, 5
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/manage/push/channels'
    assert.equal server.db.pushChannels.length, 4
    assert.equal find('.ap-table-auto-index tbody tr').length, 4

test 'user can delete push channels from edit route', (assert) ->
  visit '/manage/push/channels/1/edit'
  andThen ->
    assert.equal currentURL(), '/manage/push/channels/1/edit'
    assert.equal server.db.pushChannels.length, 5
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/manage/push/channels'
    assert.equal server.db.pushChannels.length, 4
    assert.equal find('.ap-table-auto-index tbody tr').length, 4
