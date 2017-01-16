`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import WebSocketMockServer from 'gateway-ui/tests/helpers/websocket-mock-server'`

module 'Acceptance: Notification - Delete',
  beforeEach: ->
    @port = window?.location.port
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user cannot see deleted resource after delete notification', (assert) ->
  done = assert.async()
  new WebSocketMockServer "ws://localhost:#{@port}/admin/notifications", (wsServer) ->
    Ember.run.later (->
      apiCount = server.db.apis.length
      assert.equal currentURL(), '/apis'
      assert.equal apiCount > 0, true
      assert.equal find('.ap-table-index tbody tr').length, apiCount
      wsServer.open()
      wsServer.message JSON.stringify
        resource: 'api'
        resource_id: server.db.apis[0].id
        api_id: server.db.apis[0].id
        action: 'delete'
        user: 'developer@software.com'
      assert.equal find('.ember-notify').length, 1
      Ember.run.later (->
        assert.equal find('.ap-table-index tbody tr').length, apiCount - 1
        wsServer.destroy()
        done()
      ), 1000
    ), 1000
  @application = startApp notifications: true
  server.createList 'api', 2
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/apis'
