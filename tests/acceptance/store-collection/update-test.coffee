`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Store Collection - Update',
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

test 'user can edit store collections', (assert) ->
  firstCollectionText = null
  visit '/manage/collections/1/objects'
  click '.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:first-child a:eq(0)'
  andThen ->
    firstCollectionText = find('.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:first-child').text().trim()
    assert.equal currentURL(), '/manage/collections/1/edit'
    assert.notEqual firstCollectionText, 'Updated Collection'
    assert.notEqual server.db.storeCollections[0].name, 'Updated Collection'
  fillIn '[name=name]', 'Updated Collection'
  click '[type=submit]'
  andThen ->
    firstCollectionText = find('.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:first-child').text().trim()
    assert.equal currentURL(), '/manage/collections/1/objects'
    assert.equal firstCollectionText, 'Updated Collection'
    assert.equal server.db.storeCollections[0].name, 'Updated Collection'
