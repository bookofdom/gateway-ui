`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Account - Update',
  beforeEach: ->
    @application = startApp()
    # plans
    server.createList 'plan', 3
    # accounts
    server.createList 'account', 1, planId: Math.round(Math.random() * 2) + 1
    authenticateSession @application,
      email: 'admin@test.com'
      admin: true
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to account edit route', (assert) ->
  visit '/account/edit'
  andThen ->
    assert.equal currentURL(), '/account/edit'

test 'user can edit account', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/account/edit'
      assert.equal server.db.accounts[0].name, 'Test Account'
      done()
  server.put '/account', (schema, request) ->
    body = JSON.parse request.requestBody
    payload = body.account
    if body.account?.name is 'error'
      response = new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      response = schema.account.all()[0].update payload
    after()
    response
  visit '/account/edit'
  fillIn '[name=account_name]', 'Test Account'
  click '[type=submit]'
