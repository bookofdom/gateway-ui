`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import userScenario from 'gateway/mirage/scenarios/user'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: User - Update',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to user edit route', (assert) ->
  userScenario server
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  visit '/users'
  click '.ap-table-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/users/1/edit'

test 'user can edit users', (assert) ->
  done = assert.async()
  userScenario server
  authenticateSession @application,
    email: 'admin@test.com'
    admin: true
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/users/1/edit'
      assert.equal server.db.users[0].name, 'Test User'
      done()
  server.put '/users/:id',
    makePutHandler('user', after)
  visit '/users/1/edit'
  fillIn '[name=name]', 'Test User'
  click '[type=submit]'
