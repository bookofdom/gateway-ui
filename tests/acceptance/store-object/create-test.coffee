`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Store Object - Create',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new store objects on index', (assert) ->
  done = assert.async()
  storeScenario server
  authenticateSession @application
  beforeCreateCount = server.schema.storeCollection.all()[0].store_objects.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.schema.storeCollection.all()[0].store_objects.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/store_collections/:storeCollectionId/store_objects',
    makePostChildHandler('store_collection', 'store_object', after)
  visit '/collections/1/objects'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/collections/1/objects'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  click '.ap-panel-new [type=submit]'
