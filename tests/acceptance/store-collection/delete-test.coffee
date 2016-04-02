`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`

module 'Acceptance: Store Collection - Delete',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete store collections', (assert) ->
  storeScenario server
  authenticateSession @application
  beforeDeleteCount = server.db.storeCollections.length
  visit '/collections/1/edit'
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/collections/2/objects'
    assert.equal server.db.storeCollections.length, beforeDeleteCount - 1
