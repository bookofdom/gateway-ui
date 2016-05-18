`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint Schema - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList('proxy_endpoint', 1, apiId: api.id).forEach (pe) ->
        server.createList 'proxy_endpoint_schema', 3, proxyEndpointId: pe.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.proxyEndpointSchemas.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.proxyEndpointSchemas.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas', makePostChildHandler('proxy_endpoint', 'proxy_endpoint_schema', after)
  visit '/apis/1/proxy-endpoints/1/schemas'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New schema'
  click '.ap-panel-new [type=submit]'
