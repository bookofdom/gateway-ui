`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint - Delete',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'proxy_endpoint', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete proxy endpoints from index route', (assert) ->
  visit '/apis/1/proxy-endpoints'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints'
    assert.equal server.db.proxyEndpoints.length, 3
    assert.equal find('.ap-table-auto-index tbody tr').length, 3
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints'
    assert.equal server.db.proxyEndpoints.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2

test 'user can delete proxy endpoints from edit route', (assert) ->
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal server.db.proxyEndpoints.length, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints'
    assert.equal server.db.proxyEndpoints.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2
