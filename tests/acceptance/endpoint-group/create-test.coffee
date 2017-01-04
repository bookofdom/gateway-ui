`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Endpoint Group - Create',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'endpoint_group', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new endpoint group on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.endpointGroups.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.endpointGroups.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/endpoint_groups', makePostChildHandler('api', 'endpoint_group', after)
  visit '/apis/1/groups'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/groups'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New Endpoint Group'
  click '.ap-panel-new [type=submit]'
