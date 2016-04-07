`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Library - Update',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'library', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to libraries edit route', (assert) ->
  visit '/apis/1/libraries'
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.edit"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries/1/edit'

test 'user can edit libraries', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/libraries/1/edit'
      assert.equal server.db.libraries[0].name, 'Test'
      done()
  server.put '/apis/:apiId/libraries/:id', makePutHandler('library', after)
  visit '/apis/1/libraries/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
