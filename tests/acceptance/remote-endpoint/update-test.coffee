`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint - Update',
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

test 'user can navigate to remote endpoints edit route', (assert) ->
  visit '/apis/1/remote-endpoints'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'

test 'user can edit remote endpoints', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/remote-endpoints/1/edit'
      assert.equal server.db.remoteEndpoints[0].name, 'Test'
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit '/apis/1/remote-endpoints/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
