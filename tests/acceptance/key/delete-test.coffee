`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Key - Delete',
  beforeEach: ->
    @application = startApp()
    server.createList 'key', 1
    return

  afterEach: -> destroyApp @application

test 'admin user can destroy a key', (assert) ->
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  visit '/manage/keys'
  andThen ->
    assert.equal currentURL(), '/manage/keys'
    assert.equal server.db.keys.length, 1
    assert.equal find('.ap-table-auto-index tbody tr').length, 1
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/manage/keys'
    assert.equal server.db.keys.length, 0
    assert.equal find('.ap-table-auto-index tbody tr').length, 0
