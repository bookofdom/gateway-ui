`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Shared Component - Update',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'remote_endpoint', 30, apiId: api.id
      server.createList 'shared_component', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to edit', (assert) ->
  visit '/apis/1/components'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/components/1/edit'

test 'user can edit', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/components/1/edit'
      assert.equal server.db.sharedComponents[0].name, 'Test'
      done()
  server.put '/apis/:apiId/shared_components/:id', makePutHandler('shared_component', after)
  visit '/apis/1/components/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
