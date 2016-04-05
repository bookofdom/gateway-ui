`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Store Object - Update',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to store objects edit route', (assert) ->
  storeScenario server
  authenticateSession @application
  visit '/collections/1/objects'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/collections/1/objects/1/edit'

test 'user can edit store objects', (assert) ->
  done = assert.async()
  storeScenario server
  authenticateSession @application
  afterCreate = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/collections/1/objects/1/edit'
      assert.equal server.db.storeObjects[0].id, 1
      assert.equal server.db.storeObjects[0].data.name, 'Test'
      done()
  server.put '/store_collections/:storeCollectionId/store_objects/:id',
    makePutHandler('store_object', afterCreate)
  visit '/collections/1/objects/1/edit'
  andThen ->
    findWithAssert('.ap-ace-editor')[0].aceEditor.getSession().setValue '{"name": "Test"}'
    click '[type=submit]'
