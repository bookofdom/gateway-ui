`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint - Read',
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

test 'user can navigate to proxy endpoints', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.proxy-endpoint_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints'

test 'user can view proxy endpoints', (assert) ->
  visit '/apis/1/proxy-endpoints'
  andThen ->
    count = server.db.proxyEndpoints.length
    assert.equal currentURL(), '/apis/1/proxy-endpoints'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
