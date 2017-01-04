`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Environment Variable - Create',
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

test 'user can create environment variables', (assert) ->
  done = assert.async()
  count = Object.keys(server.db.environments[0].data).length
  after = ->
    wait()
    andThen ->
      afterCount = Object.keys(server.db.environments[0].data).length
      assert.equal currentURL(), '/apis/1/environments/1/edit'
      assert.equal afterCount, count + 1
      assert.equal find('[data-t="resources.environment-variable_plural"] .ap-table-model tbody tr').length, count + 1
      assert.equal server.db.environments[0].data['test'], 'value'
      done()
  server.put '/apis/:apiId/environments/:id', makePutHandler('environment', after)
  visit '/apis/1/environments/1/edit'
  click '.panel-body > a.btn-block[data-t="resources.environment-variable"]'
  fillIn '.ap-model-form tbody tr:last-child [name=name]', 'test'
  fillIn '.ap-model-form tbody tr:last-child [name=value]', 'value'
  click '[type=submit]'
