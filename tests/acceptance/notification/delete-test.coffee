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

test 'user cannot see a deleted resource after delete notification', (assert) ->
  done = assert.async()
  new WebSocketMockServer "ws://localhost:#{@port}/admin/notifications", (wsServer) ->
    Ember.run.later (->
      apiCount = server.db.apis.length
      assert.equal currentURL(), '/apis'
      assert.equal apiCount > 0, true
      assert.equal find('.ap-table-auto-index tbody tr').length, apiCount
      wsServer.open()
      wsServer.message JSON.stringify
        resource: 'api'
        resource_id: server.db.apis[0].id
        api_id: server.db.apis[0].id
        action: 'delete'
        user: 'developer@software.com'
      assert.equal find('.ember-notify').length, 1
      Ember.run.later (->
        assert.equal find('.ap-table-auto-index tbody tr').length, apiCount - 1
        wsServer.destroy()
        done()
      ), 1000
    ), 1000
  @application = startApp notifications: true
  server.createList 'api', 2
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/apis'

test 'user cannot see a deleted resource after deleting and receiving a delete notification', (assert) ->
  done = assert.async()
  new WebSocketMockServer "ws://localhost:#{@port}/admin/notifications", (wsServer) ->
    Ember.run.later (->
      count = server.db.proxyEndpoints.length
      assert.equal currentURL(), '/apis/1/proxy-endpoints'
      assert.equal count > 0, true
      assert.equal find('.ap-table-auto-index tbody tr').length, count
      click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
      andThen ->
        wsServer.open()
        assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
        $('a[data-t="actions.delete"]').click()
        wsServer.message JSON.stringify
          resource: 'proxy-endpoint'
          resource_id: server.db.proxyEndpoints[0].id
          api_id: server.db.apis[0].id
          action: 'delete'
          user: 'developer@software.com'
        andThen ->
          assert.equal find('.ember-notify').length, 1
        Ember.run.later (->
          assert.equal currentURL(), '/apis/1/proxy-endpoints'
          assert.equal find('.ap-table-auto-index tbody tr').length, count - 1
          wsServer.destroy()
          done()
        ), 1000
    ), 1000
  @application = startApp notifications: true
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 3, apiId: api.id
    server.createList 'endpoint_group', 5, apiId: api.id
    server.createList 'proxy_endpoint', 2, apiId: api.id
  # wsServer is open, but no messages are sent
  authenticateSession @application, email: 'foo@test.com'
  visit '/apis/1/proxy-endpoints'
