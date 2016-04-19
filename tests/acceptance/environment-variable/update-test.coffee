`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Environment Variable - Update',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'environment', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can edit environment variables', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/environments/1/edit'
      assert.equal server.db.environments[0].data['test'], 'value'
      done()
  server.put '/apis/:apiId/environments/:id', makePutHandler('environment', after)
  visit '/apis/1/environments/1/edit'
  fillIn '.ap-model-form tbody tr:eq(0) [name=name]', 'test'
  fillIn '.ap-model-form tbody tr:eq(0) [name=value]', 'value'
  click '[type=submit]'
