`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Store Collection - Delete',
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

test 'user can delete store collections', (assert) ->
  beforeDeleteCount = server.db.storeCollections.length
  visit '/manage/collections/1/edit'
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/manage/collections/2/objects'
    assert.equal server.db.storeCollections.length, beforeDeleteCount - 1
    assert.equal find('.ap-app-secondary .ap-app-secondary .ap-app-secondary-sidebar > .ap-list-nav li:not([data-t="actions.new"])').length, beforeDeleteCount - 1
