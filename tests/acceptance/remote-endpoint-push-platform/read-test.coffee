`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Push Platform - Read',
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

test 'user can read remote endpoint push platforms', (assert) ->
  remoteEndpoint = server.schema.remoteEndpoint.where(type: 'push')[0]
  visit "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  andThen ->
    assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
    count = remoteEndpoint.attrs.data.push_platforms.length
    assert.equal count > 0, true
    assert.equal find('div[data-t="resources.remote-endpoint-push-platform_plural"] .ap-table-auto-index tbody tr').length, count
