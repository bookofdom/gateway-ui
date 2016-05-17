`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint Schema - Update',
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

test 'user can navigate to edit', (assert) ->
  visit '/apis/1/proxy-endpoints/1/schemas'
  click '.ap-table-index tbody tr:eq(0) a:eq(0)'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas/1/edit'

test 'user can edit', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas/1/edit'
      assert.equal server.db.proxyEndpointSchemas[0].name, 'Test'
      done()
  server.put '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas/:id', makePutHandler('proxy_endpoint_schema', after)
  visit '/apis/1/proxy-endpoints/1/schemas/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
