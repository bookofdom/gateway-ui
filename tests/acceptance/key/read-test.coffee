`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Key - Read',
  beforeEach: ->
    @application = startApp()
    server.createList 'key', 5
    return

  afterEach: -> destroyApp @application

test 'admin user can navigate to keys', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  visit '/'
  click '.ap-navbar-header [data-t="resources.account"] a'
  andThen ->
    click '.ap-app-secondary-sidebar [data-t="resources.key_plural"] a'
  andThen ->
    assert.equal currentURL(), '/account/keys'

test 'admin user can view keys', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  count = server.schema.key.all().length
  visit '/account/keys'
  andThen ->
    assert.equal currentURL(), '/account/keys'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count

test 'non-admin use cannot navigate to users', (assert) ->
  authenticateSession @application,
    email: 'nonadmin@test.com'
  visit '/'
  andThen ->
    assert.equal currentURL(), '/'
    assert.equal find('.ap-navbar-header [data-t="resources.account"]').length, 0
