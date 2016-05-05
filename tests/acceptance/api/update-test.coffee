`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: API - Update',
  beforeEach: ->
    @application = startApp()
    server.createList 'api', 1
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to API edit route', (assert) ->
  visit '/apis'
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.edit"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/edit'

test 'user can edit APIs', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/edit'
      assert.equal server.db.apis[0].name, 'Test'
      done()
  server.put '/apis/:id', makePutHandler('api', after)
  visit '/apis/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
