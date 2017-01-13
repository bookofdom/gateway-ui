`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Store Object - Update',
  beforeEach: ->
    @application = startApp()
    collections = server.createList 'store_collection', 3
    collections.forEach (collection) ->
      id = collection.id
      server.createList 'store_object', 3, storeCollectionId: id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to store objects edit route', (assert) ->
  visit '/manage/collections/1/objects'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/manage/collections/1/objects/1/edit'

test 'user can edit store objects', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/manage/collections/1/objects/1/edit'
      assert.equal server.db.storeObjects[0].id, 1
      assert.equal server.db.storeObjects[0].data.name, 'Test'
      done()
  server.put '/store_collections/:storeCollectionId/store_objects/:id',
    makePutHandler('store_object', after)
  visit '/manage/collections/1/objects/1/edit'
  andThen ->
    findWithAssert('.ap-ace-editor')[0].aceEditor.getSession().setValue '{"name": "Test"}'
    click '[type=submit]'
