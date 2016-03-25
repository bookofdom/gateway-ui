`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Password Reset Confirmation',
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

test 'user can reset password', (assert) ->
  visit '/login'
  visit '/password/reset-confirmation'
  andThen ->
    assert.equal currentURL(), '/password/reset-confirmation'
  fillIn '[name=new_password]', 'test@foo.com'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/login'
