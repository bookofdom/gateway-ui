`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Library - Create',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'library', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new library on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.libraries.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.libraries.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/libraries', makePostChildHandler('api', 'library', after)
  visit '/apis/1/libraries'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/libraries'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New library'
  click '.ap-panel-new [type=submit]'
