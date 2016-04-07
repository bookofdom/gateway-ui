`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: User - Read',
  beforeEach: ->
    @application = startApp()
    server.createList 'user', 3
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'admin user can navigate to users', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  visit '/'
  click '.ap-navbar-header [data-t="resources.user_plural"] a'
  andThen ->
    assert.equal currentURL(), '/users'
    assert.equal find('.ap-navbar-header [data-t="resources.user_plural"]').length, 1

test 'non-admin user cannot navigate to users', (assert) ->
  authenticateSession @application,
    email: 'nonadmin@test.com'
  visit '/'
  andThen ->
    assert.equal currentURL(), '/'
    assert.equal find('.ap-navbar-header [data-t="resources.user_plural"]').length, 0

test 'admin user can view users', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  count = server.schema.user.all().length
  visit '/users'
  andThen ->
    assert.equal currentURL(), '/users'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
