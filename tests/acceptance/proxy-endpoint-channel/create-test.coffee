`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Proxy Endpoint Channel - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'proxy_endpoint', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new channels', (assert) ->
  beforeCreateCount = server.db.proxyEndpointChannels.length
  visit '/apis/1/proxy-endpoints/1/edit'
  andThen ->
    assert.equal beforeCreateCount == 0, true
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/edit'
    assert.equal find('[data-t="resources.proxy-endpoint-channel_plural"] tbody tr').length, beforeCreateCount
  click 'a[data-t="resources.proxy-endpoint-channel"]'
  fillIn '[data-t="resources.proxy-endpoint-channel_plural"] [name=name]', 'push_channel'
  andThen ->
    fillIn '[data-t="resources.proxy-endpoint-channel_plural"] [name=remote_endpoint]',
      find('[data-t="resources.proxy-endpoint-channel_plural"] [name=remote_endpoint] option:nth-child(2)').val()
  click '[type=submit]'
  andThen ->
    assert.equal server.db.proxyEndpointChannels.length, beforeCreateCount + 1
    assert.equal find('[data-t="resources.proxy-endpoint-channel_plural"] tbody tr').length, beforeCreateCount + 1
