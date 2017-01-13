`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Component - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 32, apiId: api.id
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

test 'user can view proxy endpoint components', (assert) ->
  components = server.schema.proxyEndpoint.all()[0].proxy_endpoint_components
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    count = count = components.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal count > 0, true
    assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, count
