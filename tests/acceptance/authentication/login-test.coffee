`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Authentication Login',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can login with correct credentials', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  wait()
  fillIn '[name=identification]', 'test@foo.com'
  fillIn '[name=password]', 'foobar'
  click '[type=submit]'
  wait()
  andThen ->
    assert.equal session.get('isAuthenticated'), true
    assert.equal currentURL(), '/'

test 'user cannot login with incorrect credentials', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  wait()
  fillIn '[name=identification]', 'imposter@hacker.net'
  fillIn '[name=password]', 'wrong-password'
  click '[type=submit]'
  wait()
  andThen ->
    assert.equal session.get('isAuthenticated'), false
    assert.equal currentURL(), '/login'

test 'user can see error message when login fails', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  wait()
  fillIn '[name=identification]', 'imposter@hacker.net'
  fillIn '[name=password]', 'wrong-password'
  click '[type=submit]'
  wait()
  andThen ->
    assert.equal session.get('isAuthenticated'), false
    assert.equal currentURL(), '/login'
    assert.equal find('.form-actions .text-danger').text(), 'We were unable to log you in'
