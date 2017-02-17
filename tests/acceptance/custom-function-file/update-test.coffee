`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Custom Function File - Update',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList('custom_function', 1, apiId: api.id).forEach (customFunction) ->
        server.createList 'custom_function_file', 3, customFunctionId: customFunction.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to edit', (assert) ->
  visit '/apis/1/custom-functions/1/files'
  click '.ap-table-auto-index tbody tr:eq(0) a:eq(0)'
  andThen ->
    assert.equal currentURL(), '/apis/1/custom-functions/1/files/1/edit'

test 'user can edit', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/custom-functions/1/files/1/edit'
      assert.equal server.db.customFunctionFiles[0].name, 'Test'
      done()
  server.put '/apis/:apiId/custom_functions/:jobId/files/:id', makePutHandler('custom_function_file', after, 'file')
  visit '/apis/1/custom-functions/1/files/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
