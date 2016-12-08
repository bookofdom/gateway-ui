`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Channel - Delete',
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

test 'user can delete proxy endpoint channels from edit route', (assert) ->
  beforeDeleteCount = server.db.proxyEndpointChannels.length
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal server.db.proxyEndpointChannels.length, beforeDeleteCount
  click '[data-t="resources.proxy-endpoint-channel_plural"] tbody tr:nth-child(1) [data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal server.db.proxyEndpointChannels.length, beforeDeleteCount - 1
    assert.equal find('[data-t="resources.proxy-endpoint-channel_plural"] tbody tr').length, 2
