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

# find('.ap-app-secondary-sidebar > .ap-list-nav li:not([data-t="actions.new"])').length

test 'user can create new collections', (assert) ->
  storeScenario server
  beforeCreateCount = server.db.storeCollections.length
  afterCreateCount = null
  authenticateSession @application
  visit '/collections'
  andThen ->
    assert.equal beforeCreateCount > 0, true
  click '.ap-app-secondary-sidebar > .ap-list-nav li[data-t="actions.new"] a'
  andThen ->
    assert.equal currentURL(), '/collections/new'
  fillIn '[name=name]', 'New Collection'
  click '[type=submit]'
  andThen ->
    afterCreateCount = server.db.storeCollections.length
    assert.equal afterCreateCount, beforeCreateCount + 1
