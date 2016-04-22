`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Header - Delete',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete remote endpoint headers from edit route', (assert) ->
  visit '/apis/1/remote-endpoints/1/edit'
  beforeCount = Object.keys(server.db.remoteEndpoints[0].data.headers).length
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
  click '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    count = Object.keys(server.db.remoteEndpoints[0].data.headers).length
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal count, beforeCount - 1
    assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr').length, beforeCount - 1
