`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Push Platform - Create',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 100, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create remote endpoint push platforms', (assert) ->
  remoteEndpoint = server.schema.remoteEndpoint.where(type: 'push')[0]
  beforeCreateCount = remoteEndpoint.attrs.data.push_platforms.length
  visit "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
    assert.equal find('div[data-t="resources.remote-endpoint-push-platform_plural"] .ap-table-auto-index tbody tr').length, beforeCreateCount
  click '.ap-panel-edit[data-t="resources.remote-endpoint-push-platform_plural"] a[data-t="resources.remote-endpoint-push-platform"]'
  fillIn '[name=name]', 'mqtt'
  fillIn '[name=codename]', 'mqtt'
  fillIn '[name=type]', 'mqtt'
  fillIn '[name=password]', 'abc123'
  click '.ap-panel-edit [type=submit]'
  andThen ->
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
    remoteEndpoint = server.schema.remoteEndpoint.where(type: 'push')[0]
    assert.equal remoteEndpoint.attrs.data.push_platforms.length, beforeCreateCount + 1
    assert.equal find('div[data-t="resources.remote-endpoint-push-platform_plural"] .ap-table-auto-index tbody tr').length, beforeCreateCount + 1
