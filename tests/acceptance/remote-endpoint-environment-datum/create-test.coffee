`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Environment Datum - Create',
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

test 'user can edit remote endpoint environment data', (assert) ->
  done = assert.async()
  beforeCount = server.schema.remoteEndpoint.all()[0].remote_endpoint_environment_data.length
  after = ->
    wait()
    andThen ->
      count = server.schema.remoteEndpoint.all()[0].environment_data.length
      assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
      assert.equal count, beforeCount + 1
      assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] .ap-table-auto-index tbody tr').length, beforeCount + 1
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit '/apis/1/remote-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
    assert.equal find('.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] .ap-table-auto-index tbody tr').length, beforeCount
  click '.ap-panel-edit[data-t="resources.remote-endpoint-environment-datum_plural"] a[data-t="resources.remote-endpoint-environment-datum"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/environment-data/new'
  fillIn '[name=url]', 'http://foobars.com'
  fillIn '[name=method]', 'GET'
  click '[type=submit]'
