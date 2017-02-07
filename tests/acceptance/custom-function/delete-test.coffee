`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Custom Function - Delete',
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

test 'user can delete custom functions from edit route', (assert) ->
  visit '/apis/1/custom-functions/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/custom-functions/1/edit'
    assert.equal server.db.customFunctions.length, 5
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/custom-functions'
    assert.equal server.db.customFunctions.length, 4
    assert.equal find('.ap-table-auto-index tbody tr').length, 4
