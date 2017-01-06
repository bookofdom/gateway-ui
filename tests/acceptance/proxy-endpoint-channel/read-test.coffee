`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Channel - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList('proxy_endpoint', 1, apiId: api.id).forEach (proxyEndpoint) ->
        server.createList 'proxy_endpoint_channel', 3, proxyEndpointId: proxyEndpoint.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can view proxy endpoint channels', (assert) ->
  beforeReadCount = server.db.proxyEndpointChannels.length
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal server.db.proxyEndpointChannels.length, beforeReadCount
