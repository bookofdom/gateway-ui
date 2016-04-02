`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`

module 'Acceptance: Store Collection - Create',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new store collections', (assert) ->
  storeScenario server
  authenticateSession @application
  beforeCreateCount = server.db.storeCollections.length
  visit '/collections/1/objects'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/collections/1/objects'
  click '.ap-app-secondary-sidebar > .ap-list-nav li[data-t="actions.new"] a'
  fillIn '[name=name]', 'New Collection'
  click '[type=submit]'
  andThen ->
    assert.equal server.db.storeCollections.length, beforeCreateCount + 1

test 'new store collections are visible in UI', (assert) ->
  authenticateSession @application
  visit '/collections/new'
  andThen ->
    assert.equal find('.ap-app-secondary-sidebar > .ap-list-nav li:not([data-t="actions.new"])').length, 0
  fillIn '[name=name]', 'New Collection'
  click '[type=submit]'
  andThen ->
    assert.equal find('.ap-app-secondary-sidebar > .ap-list-nav li:not([data-t="actions.new"])').length, 1
