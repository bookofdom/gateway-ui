`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Custom Function - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'custom_function', 5, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to custom functions', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.custom-function_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/custom-functions'

test 'user can view custom functions', (assert) ->
  visit '/apis/1/custom-functions'
  andThen ->
    count = server.db.customFunctions.length
    assert.equal currentURL(), '/apis/1/custom-functions'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
