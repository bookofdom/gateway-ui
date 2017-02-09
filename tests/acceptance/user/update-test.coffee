`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: User - Update',
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

test 'user can navigate to user edit route', (assert) ->
  visit '/account/users'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/account/users/1/edit'

test 'user can edit users', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/account/users/1/edit'
      assert.equal server.db.users[0].name, 'Test User'
      done()
  server.put '/users/:id',
    makePutHandler('user', after)
  visit '/account/users/1/edit'
  fillIn '[name=name]', 'Test User'
  click '[type=submit]'
