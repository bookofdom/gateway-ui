`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Authentication Logout',
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

test 'user can logout', (assert) ->
  session = currentSession @application
  authenticateSession @application
  visit '/'
  andThen ->
    assert.equal session.get('isAuthenticated'), true
  click '[data-t="actions.logout"] a'
  andThen ->
    assert.equal session.get('isAuthenticated'), false
