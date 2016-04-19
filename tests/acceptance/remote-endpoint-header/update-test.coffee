`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Header - Update',
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

test 'user can edit remote endpoint headers', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
      assert.equal server.db.remoteEndpoints[0].data.headers['Test'], 'value'
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit '/apis/1/remote-endpoints/1/edit'
  fillIn '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr:eq(0) [name=name]', 'Test'
  fillIn '.ap-panel-edit[data-t="resources.remote-endpoint-header_plural"] .ap-table-model tbody tr:eq(0) [name=value]', 'value'
  click '[type=submit]'
