`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint - Update',
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

test 'user can navigate to proxy endpoints edit route', (assert) ->
  visit '/apis/1/proxy-endpoints'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'

test 'user can edit proxy endpoints', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
      assert.equal server.db.proxyEndpoints[0].name, 'Test'
      done()
  server.put '/apis/:apiId/proxy_endpoints/:id', makePutHandler('proxy_endpoint', after)
  visit '/apis/1/proxy-endpoints/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
