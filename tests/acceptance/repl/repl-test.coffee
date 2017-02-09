`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import WebSocketMockServer from 'gateway-ui/tests/helpers/websocket-mock-server'`

module 'Acceptance: REPL',
  beforeEach: ->
    port = window?.location.port
    @wsServerUrl = new RegExp "ws://localhost:#{port}/admin/apis/\\d*/environments/\\d*/repl/socket"
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application


test 'user can navigate to REPL', (assert) ->
  done = assert.async()
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    andThen ->
      assert.equal currentURL(), '/apis/1/repl'
      wsServer.destroy()
      done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 1, apiId: api.id
  authenticateSession @application
  visit '/apis/1'
  click '[data-secondary="nav.descriptions.repl"] a'


test 'user can see input echoed in terminal', (assert) ->
  done = assert.async()
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    andThen ->
      assert.equal currentURL(), '/apis/1/repl'
      fillIn '.ap-repl-terminal input', '"random JS string"'
      click '.ap-repl-terminal [type="submit"]'
      andThen ->
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.match(/^> "random JS string"/m)?.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 1, apiId: api.id
  authenticateSession @application
  visit '/apis/1/repl'


test 'user can see output echoed in terminal', (assert) ->
  done = assert.async()
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    wsServer.onReceive = (data) ->
      wsServer.message JSON.stringify
        type: 'output'
        data: "#{data}"
    andThen ->
      assert.equal currentURL(), '/apis/1/repl'
      fillIn '.ap-repl-terminal input', '"random JS string"'
      click '.ap-repl-terminal [type="submit"]'
      andThen ->
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.match(/^"random JS string"/m)?.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 1, apiId: api.id
  authenticateSession @application
  visit '/apis/1/repl'


test 'user can clear terminal with command `.c`', (assert) ->
  done = assert.async()
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    andThen ->
      assert.equal currentURL(), '/apis/1/repl'
      output = find('.ap-repl-terminal pre').text()
      assert.ok output.length
      fillIn '.ap-repl-terminal input', '.c'
      click '.ap-repl-terminal [type="submit"]'
      andThen ->
        output = find('.ap-repl-terminal pre').text()
        assert.notOk output.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 1, apiId: api.id
  authenticateSession @application
  visit '/apis/1/repl'


test 'user can clear terminal with command `.clear`', (assert) ->
  done = assert.async()
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    andThen ->
      assert.equal currentURL(), '/apis/1/repl'
      output = find('.ap-repl-terminal pre').text()
      assert.ok output.length
      fillIn '.ap-repl-terminal input', '.clear'
      click '.ap-repl-terminal [type="submit"]'
      andThen ->
        output = find('.ap-repl-terminal pre').text()
        assert.notOk output.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList 'environment', 1, apiId: api.id
  authenticateSession @application
  visit '/apis/1/repl'


test 'user can switch environments with command `.e`', (assert) ->
  done = assert.async()
  wsRunCount = 0
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    wsRunCount++
    if wsRunCount == 1
      andThen ->
        assert.equal currentURL(), '/apis/1/repl'
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.length
        fillIn '.ap-repl-terminal input', '.e staging'
        click '.ap-repl-terminal [type="submit"]'
    else
      andThen ->
        assert.equal currentURL(), '/apis/1/repl?environment=2'
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.match(/^Environment:  /m)?.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList('environment', 2, apiId: api.id).forEach (env) ->
      env.name = 'Development' if env.id == 1
      env.name = 'Staging' if env.id == 2
  authenticateSession @application
  visit '/apis/1/repl'


test 'user can switch environments with command `.environment`', (assert) ->
  done = assert.async()
  wsRunCount = 0
  new WebSocketMockServer @wsServerUrl, (wsServer) ->
    wsServer.open()
    wsRunCount++
    if wsRunCount == 1
      andThen ->
        assert.equal currentURL(), '/apis/1/repl'
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.length
        fillIn '.ap-repl-terminal input', '.environment staging'
        click '.ap-repl-terminal [type="submit"]'
    else
      andThen ->
        assert.equal currentURL(), '/apis/1/repl?environment=2'
        output = find('.ap-repl-terminal pre').text()
        assert.ok output.match(/^Environment:  /m)?.length
        wsServer.destroy()
        done()
  @application = startApp()
  server.createList('api', 1).forEach (api) ->
    server.createList('environment', 2, apiId: api.id).forEach (env) ->
      env.name = 'Development' if env.id == 1
      env.name = 'Staging' if env.id == 2
  authenticateSession @application
  visit '/apis/1/repl'
