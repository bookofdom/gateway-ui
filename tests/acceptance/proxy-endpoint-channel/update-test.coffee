`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Channel - Update',
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

test 'user can edit proxy endpoint channels', (assert) ->
  visit '/apis/1/proxy-endpoints/1/edit'
  fillIn '[data-t="resources.proxy-endpoint-channel_plural"] tbody tr:nth-child(1) [name=name]', 'new_push_channel'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal server.db.proxyEndpointChannels[0].name, 'new_push_channel'
