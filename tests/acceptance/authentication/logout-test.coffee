`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Authentication Logout',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can logout', (assert) ->
  session = currentSession @application
  authenticateSession @application
  visit '/'
  andThen ->
    assert.equal session.get('isAuthenticated'), true
  click '[data-t="actions.logout"] a'
  andThen ->
    assert.equal session.get('isAuthenticated'), false
