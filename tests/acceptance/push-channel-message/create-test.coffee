`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Channel Message - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 5).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
    server.createList('push_channel', 1).forEach (channel) ->
      server.createList 'push_channel_message', 5, pushChannelId: channel.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new push channel messages', (assert) ->
  beforeCreateCount = server.db.pushChannelMessages.length
  visit '/manage/push/messages'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/push/messages'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=push_channel]', find('[name=push_channel] option:eq(1)').val()
  click '.ap-panel-new [type=submit]'
  andThen ->
    assert.equal server.db.pushChannelMessages.length, beforeCreateCount + 1
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
