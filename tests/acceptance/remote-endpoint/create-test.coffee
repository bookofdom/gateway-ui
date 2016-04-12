`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint - Create',
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

test 'user can create new remote endpoints on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.remoteEndpoints.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.remoteEndpoints.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/remote_endpoints', makePostChildHandler('api', 'remote_endpoint', after)
  visit '/apis/1/remote-endpoints'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/remote-endpoints'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New remote endpoint'
  fillIn '[name=codename]', 'newpoint'
  click '.ap-panel-new [type=submit]'
