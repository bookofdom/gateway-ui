`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Library - Delete',
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

test 'user can delete libraries from index route', (assert) ->
  visit '/apis/1/libraries'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries'
    assert.equal server.db.libraries.length, 3
    assert.equal find('.ap-table-index tbody tr').length, 3
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries'
    assert.equal server.db.libraries.length, 2
    assert.equal find('.ap-table-index tbody tr').length, 2

test 'user can delete libraries from edit route', (assert) ->
  visit '/apis/1/libraries/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries/1/edit'
    assert.equal server.db.libraries.length, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries'
    assert.equal server.db.libraries.length, 2
    assert.equal find('.ap-table-index tbody tr').length, 2
