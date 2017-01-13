`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Store Object - Delete',
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

test 'user can delete store objects', (assert) ->
  beforeDeleteCount = server.schema.storeCollection.all()[0].store_objects.length
  visit '/manage/collections/1/objects/1/edit'
  click 'a[data-t="actions.delete"]'
  andThen ->
    afterDeleteCount = server.schema.storeCollection.all()[0].store_objects.length
    assert.equal currentURL(), '/manage/collections/1/objects'
    assert.equal afterDeleteCount, beforeDeleteCount - 1
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeDeleteCount - 1
