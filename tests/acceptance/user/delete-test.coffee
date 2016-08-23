`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: User - Delete',
  beforeEach: ->
    @application = startApp()
    server.createList 'user', 3
    authenticateSession @application,
      email: 'admin@test.com'
      admin: true
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete users', (assert) ->
  count = server.schema.user.all().length
  visit '/account/users/1/edit'
  click 'a[data-t="actions.delete"]'
  andThen ->
    afterDeleteCount = server.schema.user.all().length
    assert.equal currentURL(), '/account/users'
    assert.equal count > 0, true
    assert.equal afterDeleteCount, count - 1
    assert.equal find('.ap-table-index tbody tr').length, count - 1
