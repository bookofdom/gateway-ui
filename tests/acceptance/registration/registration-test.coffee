`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Registration',
  beforeEach: ->
    @application = startApp()
    # plans
    server.createList 'plan', 3
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can register for an account', (assert) ->
  visit '/login'
  click '[href="/registration"]'
  andThen ->
    assert.equal currentURL(), '/registration'
  fillIn '[name=email]', 'test@foo.com'
  fillIn '[name=password]', 'foobar'
  fillIn '[name=password_confirmation]', 'foobar'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/registration/success'
