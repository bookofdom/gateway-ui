`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint Environment Datum - Delete',
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

test 'user can delete remote endpoint environment data from edit route', (assert) ->
  beforeCount = server.schema.remoteEndpoint.all()[0].remote_endpoint_environment_data.length
  visit '/apis/1/remote-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
  click '.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] .ap-table-model tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    # Notice the different attribute name for environment data?  That's because
    # for mock purposes, it's easier to have a dumb property for embedded data.
    # The mock backend doesn't use `environment_data`, it just stores whatever
    # the client passes in.
    count = server.schema.remoteEndpoint.all()[0].environment_data.length
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal count, beforeCount - 1
    assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] .ap-table-model tbody tr').length, beforeCount - 1
