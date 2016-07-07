`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Channel Message - Read',
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

test 'user can view push channel messages', (assert) ->
  visit '/manage/push/messages'
  andThen ->
    count = server.db.pushChannelMessages.length
    assert.equal currentURL(), '/manage/push/messages'
    assert.equal count > 0, true
    assert.equal find('.ap-table-model tbody tr').length, count

test 'user can view push channel message', (assert) ->
  visit '/manage/push/messages/1'
  andThen ->
    assert.equal currentURL(), '/manage/push/messages/1'
