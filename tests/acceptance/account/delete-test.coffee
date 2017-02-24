`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Account - Delete',
  beforeEach: ->
    @application = startApp()
    server.createList 'account', 1
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'admin user can delete account', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  count = server.schema.account.all().length
  visit '/account/edit'
  andThen ->
    assert.equal currentURL(), '/account/edit'
    assert.equal count > 0, true
    assert.equal find('input[name="account_name"]').length, count
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal find('input[name="account_name"]').length, 0
