`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: API - Create',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new APIs on index', (assert) ->
  done = assert.async()
  server.createList 'api', 1
  authenticateSession @application
  beforeCreateCount = server.db.apis.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.apis.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis', makePostHandler('api', after)
  visit '/apis'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New API'
  click '.ap-panel-new [type=submit]'
