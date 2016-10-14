`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import WebSocketMockServer from 'gateway/tests/helpers/websocket-mock-server'`

module 'Acceptance: Notification - Read',
  beforeEach: ->
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user sees no notifications when none are sent (notifications enabled)', (assert) ->
  done = assert.async()
  new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (wsServer) ->
    wsServer.open()
    andThen ->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 0
      wsServer.destroy()
      done()
  @application = startApp notifications: true
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/'

test 'user can see notifications that are sent (notifications enabled)', (assert) ->
  done = assert.async()
  new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (wsServer) ->
    wsServer.open()
    wsServer.message JSON.stringify
      resource: 'api'
      resource_id: 1
      api_id: 1
      action: 'update'
      user: 'developer@software.com'
    andThen ->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 1
      wsServer.destroy()
      done()
  @application = startApp notifications: true
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/'

test 'user sees no notifications when none are sent (notifications disabled)', (assert) ->
  done = assert.async()
  wsServer = new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (wsServer) ->
    wsServer.open()
  @application = startApp notifications: false
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/'
  andThen ->
    Ember.run.later (->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 0
      wsServer.destroy()
      done()
    ), 1000

test 'user sees no notifications that a server is configured to send when notifications are disabled in the frontend', (assert) ->
  done = assert.async()
  wsServer = new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (wsServer) ->
    wsServer.open()
    wsServer.message JSON.stringify
      resource: 'api'
      resource_id: 1
      api_id: 1
      action: 'update'
      user: 'developer@software.com'
  @application = startApp notifications: false
  # wsServer is open, and messages are configured to be sent (but won't send)
  authenticateSession @application, email: 'foo@test.com'
  visit '/'
  andThen ->
    Ember.run.later (->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 0
      wsServer.destroy()
      done()
    ), 1000
