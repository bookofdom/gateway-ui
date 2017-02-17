`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Custom Function Test - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList('custom_function', 1, apiId: api.id).forEach (customFunction) ->
        server.createList 'custom_function_test', 3, customFunctionId: customFunction.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.customFunctionTests.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.customFunctionTests.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/custom_functions/:customFunctionId/tests', makePostChildHandler('custom_function', 'custom_function_test', after, 'test')
  visit '/apis/1/custom-functions/1/tests'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/custom-functions/1/tests'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New file'
  click '.ap-panel-new [type=submit]'
