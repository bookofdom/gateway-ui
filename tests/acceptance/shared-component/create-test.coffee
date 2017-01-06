`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Shared Component - Create',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'remote_endpoint', 32, apiId: api.id
      server.createList 'shared_component', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.sharedComponents.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.sharedComponents.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal currentURL(), '/apis/1/components/2/edit'
      done()
  server.post '/apis/:apiId/shared_components', makePostChildHandler('api', 'shared_component', after)
  visit '/apis/1/components'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/components'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  click '[data-t="types.proxy-endpoint-component.js"] a'
  fillIn '[name=name]', 'New'
  click '[type=submit]'
