`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Store Object - Read',
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

test 'user can navigate to store objects', (assert) ->
  visit '/'
  click '[data-t="nav.manage"] a'
  andThen ->
    assert.equal currentURL(), '/collections/1/objects'

test 'user can navigate among store collections\' store objects index routes', (assert) ->
  visit '/collections/1/objects'
  click '.ap-app-secondary-sidebar > .ap-list-nav li:eq(1) a'
  andThen ->
    assert.equal currentURL(), '/collections/2/objects'
  click '.ap-app-secondary-sidebar > .ap-list-nav li:eq(2) a'
  andThen ->
    assert.equal currentURL(), '/collections/3/objects'
