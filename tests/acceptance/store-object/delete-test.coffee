`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`

module 'Acceptance: Store Object - Delete',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete store objects', (assert) ->
  storeScenario server
  authenticateSession @application
  beforeDeleteCount = server.schema.storeCollection.all()[0].store_objects.length
  visit '/collections/1/objects/1/edit'
  click 'a[data-t="actions.delete"]'
  andThen ->
    afterDeleteCount = server.schema.storeCollection.all()[0].store_objects.length
    assert.equal currentURL(), '/collections/1/objects'
    assert.equal afterDeleteCount, beforeDeleteCount - 1
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeDeleteCount - 1
