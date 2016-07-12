`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint Component - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 28, apiId: api.id
      server.createList 'shared_component', 10, apiId: api.id
      server.createList('proxy_endpoint', 1, apiId: api.id).forEach (pe) ->
        server.createList 'proxy_endpoint_component', 10, proxyEndpointId: pe.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create proxy endpoint components', (assert) ->
  done = assert.async()
  beforeCount = server.schema.proxyEndpoint.all()[0].proxy_endpoint_components.length
  after = ->
    wait()
    andThen ->
      count = server.schema.proxyEndpoint.all()[0].components.length
      assert.equal !!currentURL().toString().match(/\/apis\/1\/proxy-endpoints\/1\/components\/.*\/edit/), true
      assert.equal count, beforeCount + 1
      assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, beforeCount + 1
      done()
  server.put '/apis/:apiId/proxy_endpoints/:id', makePutHandler('proxy_endpoint', after)
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, beforeCount

  click '.ap-app-tertiary-sidebar .ap-list-nav:eq(0) [data-t="actions.new"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/components/new'
  click '[data-t="types.proxy-endpoint-component.js"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/components/new/js'
  click '[type=submit]'
