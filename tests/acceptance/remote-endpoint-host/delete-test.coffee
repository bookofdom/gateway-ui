`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Host - Delete',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 10, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete remote endpoint hosts from edit route', (assert) ->
  remoteEndpoint = server.schema.remoteEndpoint.where(type: 'mongodb')[0]
  beforeCount = remoteEndpoint.attrs.data.config.hosts.length
  visit "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  andThen ->
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  click '.ap-panel-edit[data-t="resources.host_plural"] .ap-table-model tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    remoteEndpoint = server.schema.remoteEndpoint.where(type: 'mongodb')[0]
    count = remoteEndpoint.attrs.data.config.hosts.length
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
    assert.equal count, beforeCount - 1
    assert.equal find('.ap-panel-edit[data-t="resources.host_plural"] .ap-table-model tbody tr').length, beforeCount - 1
