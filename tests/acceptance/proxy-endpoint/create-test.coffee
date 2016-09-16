`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'proxy_endpoint', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new proxy endpoints on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.proxyEndpoints.length
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/proxy-endpoints/2/edit'
      afterCreateCount = server.db.proxyEndpoints.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/proxy_endpoints', makePostChildHandler('api', 'proxy_endpoint', after)
  visit '/apis/1/proxy-endpoints'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/proxy-endpoints'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New proxy endpoint'
  click '.ap-panel-new [type=submit]'
