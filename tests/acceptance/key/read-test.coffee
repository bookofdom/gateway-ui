`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Key - Read',
  beforeEach: ->
    @application = startApp()
    server.createList 'account', 1
    server.createList 'key', 5
    return

  afterEach: -> destroyApp @application

test 'user can navigate to keys', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    #admin: true
  visit '/'
  click '[data-t="nav.manage"] a'
  andThen ->
    click '.ap-app-secondary-sidebar [data-t="resources.key_plural"] a'
  andThen ->
    assert.equal currentURL(), '/manage/keys'

test 'user can view keys', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    #admin: true
  count = server.schema.key.all().length
  visit '/manage/keys'
  andThen ->
    assert.equal currentURL(), '/manage/keys'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
