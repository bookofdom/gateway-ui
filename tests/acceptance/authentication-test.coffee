`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Authentication',
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

test 'visiting /login', (assert) ->
  visit '/login'
  andThen ->
    assert.equal currentURL(), '/login'

test 'visiting / when unauthenticated redirects to /login', (assert) ->
  session = currentSession @application
  visit '/'
  andThen ->
    assert.equal session.get('isAuthenticated'), false
    assert.equal currentURL(), '/login'

test 'visiting /login when authenticated redirects to /', (assert) ->
  session = currentSession @application
  authenticateSession @application
  visit '/login'
  andThen ->
    assert.equal session.get('isAuthenticated'), true
    assert.equal currentURL(), '/'

# TODO:  interactive login tests for both correct and incorrect creds
