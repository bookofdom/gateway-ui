`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: User - Create',
  beforeEach: ->
    @application = startApp()
    server.createList 'user', 3
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new users on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.users.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.users.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/users', makePostHandler('user', after)
  visit '/account/users'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/account/users'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New User'
  fillIn '[name=email]', 'user@example.net'
  click '.ap-panel-new [type=submit]'
