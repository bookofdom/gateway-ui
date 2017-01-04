`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Environment Datum - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList('remote_endpoint', 1, apiId: api.id).forEach (remoteEndpoint) ->
        server.createList 'remote_endpoint_environment_datum', 3,
          remoteEndpointId: remoteEndpoint.id
          type: remoteEndpoint.type
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can view remote endpoint environment data', (assert) ->
  count = server.schema.remoteEndpoint.all()[0].remote_endpoint_environment_data.length
  visit '/apis/1/remote-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal count > 0, true
    assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] .ap-table-model tbody tr').length, count
