`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Channel - Create',
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

test 'user can create new push channels', (assert) ->
  beforeCreateCount = server.db.pushChannels.length
  visit '/manage/push/channels'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/push/channels'
    assert.equal find('.ap-table-model tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New push channel'
  fillIn '[name=expires]', '2016-05-31T00:00:00Z'
  andThen ->
    fillIn '[name=api]', find("[name=api] option:nth-child(2)").val()
  andThen ->
    fillIn '[name=remote_endpoint]', find("[name=remote_endpoint] option:nth-child(2)").val()
  click '.ap-panel-new [type=submit]'
  andThen ->
    assert.equal server.db.pushChannels.length, beforeCreateCount + 1
    assert.equal find('.ap-table-model tbody tr').length, beforeCreateCount + 1
