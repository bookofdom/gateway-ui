`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Authentication Login',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: ->
    # Manually shutdown pretender after each test or else tests will hang:
    # https://github.com/samselikoff/ember-cli-mirage/issues/142
    server.pretender.shutdown()
    Ember.run @application, 'destroy'

test 'user can login with correct credentials', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  fillIn '[name=identification]', 'test@foo.com'
  fillIn '[name=password]', 'foobar'
  click '[type=submit]'
  andThen ->
    assert.equal session.get('isAuthenticated'), true
    assert.equal currentURL(), '/'

test 'user cannot login with incorrect credentials', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  fillIn '[name=identification]', 'imposter@hacker.net'
  fillIn '[name=password]', 'wrong-password'
  click '[type=submit]'
  andThen ->
    assert.equal session.get('isAuthenticated'), false
    assert.equal currentURL(), '/login'

test 'user can see error message when login fails', (assert) ->
  server.loadFixtures 'sessions'
  session = currentSession @application
  visit '/login'
  fillIn '[name=identification]', 'imposter@hacker.net'
  fillIn '[name=password]', 'wrong-password'
  click '[type=submit]'
  andThen ->
    assert.equal session.get('isAuthenticated'), false
    assert.equal currentURL(), '/login'
    assert.equal find('.form-actions .text-danger').text(), 'We were unable to log you in'
