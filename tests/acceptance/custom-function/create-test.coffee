`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Custom Function - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'custom_function', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new custom functions on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.customFunctions.length
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/custom-functions/2/edit'
      afterCreateCount = server.db.customFunctions.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/custom_functions', makePostChildHandler('api', 'custom_function', after)
  visit '/apis/1/custom-functions'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/custom-functions'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New custom function'
  fillIn '[name=language]', 'other'
  click '.ap-panel-new [type=submit]'
