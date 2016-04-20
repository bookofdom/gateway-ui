`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Schema - Delete',
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

test 'user can delete from index', (assert) ->
  visit '/apis/1/proxy-endpoints/1/schemas'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_schemas.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'
    assert.equal count, 3
    assert.equal find('.ap-table-index tbody tr').length, 3
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_schemas.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2

test 'user can delete from edit', (assert) ->
  visit '/apis/1/proxy-endpoints/1/schemas/1/edit'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_schemas.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas/1/edit'
    assert.equal count, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    count = server.schema.proxyEndpoint.all()[0].proxy_endpoint_schemas.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/schemas'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2
