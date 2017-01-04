`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

storeScenario = (server) ->
  collections = server.createList 'store_collection', 3
  collections.forEach (collection) ->
    id = collection.id
    server.createList 'store_object', 3, storeCollectionId: id

module 'Acceptance: Store Collection - Read',
  beforeEach: ->
    @application = startApp()
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'store collections index redirects to new store collection when none exist yet', (assert) ->
  visit '/manage/collections/'
  andThen ->
    assert.equal currentURL(), '/manage/collections/new'

test 'store collections index redirects to first store collection\'s store objects index', (assert) ->
  storeScenario server
  visit '/manage/collections/'
  andThen ->
    assert.equal currentURL(), '/manage/collections/1/objects'

test 'user can navigate to store collections', (assert) ->
  storeScenario server
  visit '/'
  click '[data-t="nav.manage"] a'
  andThen ->
    assert.equal currentURL(), '/manage/collections/1/objects'

test 'user can navigate among store collections\' store objects index routes', (assert) ->
  storeScenario server
  visit '/manage/collections/1/objects'
  click '.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:eq(1) a:eq(1)'
  andThen ->
    assert.equal currentURL(), '/manage/collections/2/objects'
  click '.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:eq(2) a:eq(1)'
  andThen ->
    assert.equal currentURL(), '/manage/collections/3/objects'
