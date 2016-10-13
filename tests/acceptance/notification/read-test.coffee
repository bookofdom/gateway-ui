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

test 'user sees no notifications when none are sent', (assert) ->
  done = assert.async()
  new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (server) ->
    server.open()
    andThen ->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 0
      server.destroy()
      done()
  @application = startApp notifications: true
  # server is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/'

test 'user can see notifications that are sent', (assert) ->
  done = assert.async()
  new WebSocketMockServer 'ws://localhost:7357/admin/notifications', (server) ->
    server.open()
    server.message JSON.stringify
      resource: 'proxy_endpoint'
      resource_id: 1
      api_id: 1
      action: 'update'
      user: 'developer@software.com'
    andThen ->
      assert.equal currentURL(), '/'
      assert.equal find('.ember-notify').length, 1
      server.destroy()
      done()
  @application = startApp notifications: true
  # server is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/'
