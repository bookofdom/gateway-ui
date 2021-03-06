`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Custom Function Test - Read',
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

test 'user can navigate to', (assert) ->
  visit '/apis/1/custom-functions/1'
  click '.ap-app-tertiary-sidebar [data-t="resources.custom-function-test_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/custom-functions/1/tests'

test 'user can view', (assert) ->
  visit '/apis/1/custom-functions/1/tests'
  andThen ->
    count = server.schema.customFunction.all()[0].custom_function_tests.length
    assert.equal currentURL(), '/apis/1/custom-functions/1/tests'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
