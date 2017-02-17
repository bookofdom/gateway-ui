`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: API - Delete',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete APIs from index route', (assert) ->
  server.createList 'api', 2
  authenticateSession @application
  visit '/apis'
  andThen ->
    assert.equal currentURL(), '/apis'
    assert.equal server.db.apis.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/apis'
    assert.equal server.db.apis.length, 1
    assert.equal find('.ap-table-auto-index tbody tr').length, 1

test 'user can delete APIs from edit route', (assert) ->
  server.createList 'api', 2
  authenticateSession @application
  visit '/apis/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/edit'
    assert.equal server.db.apis.length, 2
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis'
    assert.equal server.db.apis.length, 1
    assert.equal find('.ap-table-auto-index tbody tr').length, 1
