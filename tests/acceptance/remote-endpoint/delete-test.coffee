`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint - Delete',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete remote endpoints from index route', (assert) ->
  visit '/apis/1/remote-endpoints'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints'
    assert.equal server.db.remoteEndpoints.length, 3
    assert.equal find('.ap-table-auto-index tbody tr').length, 3
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints'
    assert.equal server.db.remoteEndpoints.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2

test 'user can delete remote endpoints from edit route', (assert) ->
  visit '/apis/1/remote-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal server.db.remoteEndpoints.length, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints'
    assert.equal server.db.remoteEndpoints.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2
