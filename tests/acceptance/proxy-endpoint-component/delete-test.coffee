`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Component - Delete',
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

test 'user can delete proxy endpoint components from edit route', (assert) ->
  visit '/apis/1/proxy-endpoints/1/components/1/edit'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_components.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/components/1/edit'
    assert.equal count, 10
  click 'a[data-t="actions.delete"]'
  andThen ->
    # Notice the different attribute name for components?  That's because
    # for mock purposes, it's easier to have a dumb property for embedded data.
    # The mock backend doesn't use `components`, it just stores whatever
    # the client passes in.
    count = server.schema.proxyEndpoint.all()[0].components.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal count, 9
    assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, 9
