`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Environment - Create',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'environment', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new environment on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.environments.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.environments.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/environments', makePostChildHandler('api', 'environment', after)
  visit '/apis/1/environments'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/environments'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New environment'
  click '.ap-panel-new [type=submit]'
