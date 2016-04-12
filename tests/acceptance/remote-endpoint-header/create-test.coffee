`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Header - Create',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create remote endpoint headers', (assert) ->
  done = assert.async()
  beforeCount = Object.keys(server.db.remoteEndpoints[0].data.headers).length
  after = ->
    wait()
    andThen ->
      count = Object.keys(server.db.remoteEndpoints[0].data.headers).length
      assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
      assert.equal count, beforeCount + 1
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit '/apis/1/remote-endpoints/1/edit'
  click '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] a[data-t="resources.remote-endpoint-header"]'
  fillIn '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr:last-child [name=name]', 'Test'
  fillIn '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr:last-child [name=value]', 'value'
  click '[type=submit]'
