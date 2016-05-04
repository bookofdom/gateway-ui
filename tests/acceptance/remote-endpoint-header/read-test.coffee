`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Header - Read',
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

test 'user can view remote endpoint headers', (assert) ->
  visit '/apis/1/remote-endpoints/1/edit'
  andThen ->
    count = Object.keys(server.db.remoteEndpoints[0].data.headers).length
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal count > 0, true
    assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr').length, count