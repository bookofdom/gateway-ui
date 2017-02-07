`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Custom Function File - Delete',
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

test 'user can delete from index', (assert) ->
  visit '/apis/1/custom-functions/1/files'
  andThen ->
    count = server.schema.customFunction.all()[0].custom_function_files.length
    assert.equal currentURL(), '/apis/1/custom-functions/1/files'
    assert.equal count, 3
    assert.equal find('.ap-table-index tbody tr').length, 3
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    count = server.schema.customFunction.all()[0].custom_function_files.length
    assert.equal currentURL(), '/apis/1/custom-functions/1/files'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2

test 'user can delete from edit', (assert) ->
  visit '/apis/1/custom-functions/1/files/1/edit'
  andThen ->
    count = server.schema.customFunction.all()[0].custom_function_files.length
    assert.equal currentURL(), '/apis/1/custom-functions/1/files/1/edit'
    assert.equal count, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    count = server.schema.customFunction.all()[0].custom_function_files.length
    assert.equal currentURL(), '/apis/1/custom-functions/1/files'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2
