`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Schema - Read',
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

test 'user can navigate to', (assert) ->
  visit '/apis/1/proxy-endpoints/1'
  click '.ap-app-tertiary-sidebar [data-t="resources.proxy-endpoint-schema_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'

test 'user can view', (assert) ->
  visit '/apis/1/proxy-endpoints/1/schemas'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_schemas.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
