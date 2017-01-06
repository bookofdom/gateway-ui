`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Host - Read',
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

test 'user can view remote endpoint hosts', (assert) ->
  remoteEndpoint = server.schema.remoteEndpoint.where(type: 'mongodb')[0]
  visit "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  andThen ->
    count = remoteEndpoint.attrs.data.config.hosts.length
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
    assert.equal count > 0, true
    assert.equal find('.ap-panel-edit[data-t="resources.host_plural"] .ap-table-model tbody tr').length, count
