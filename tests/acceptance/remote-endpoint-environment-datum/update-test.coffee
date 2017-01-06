`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Environment Datum - Update',
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
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
      assert.equal server.schema.remoteEndpoint.all()[0].environment_data[0].url, 'http://foobars.com'
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit '/apis/1/remote-endpoints/1/environment-data/1/edit'
  fillIn '[name=url]', 'http://foobars.com'
  click '[type=submit]'
