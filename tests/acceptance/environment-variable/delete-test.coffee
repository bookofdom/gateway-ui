`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Environment Variable - Delete',
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

test 'user can delete environment variables from edit route', (assert) ->
  visit '/apis/1/environments/1/edit'
  count = Object.keys(server.db.environments[0].data).length
  andThen ->
    assert.equal currentURL(), '/apis/1/environments/1/edit'
    assert.equal count > 0, true
    assert.equal find('[data-t="resources.environment-variable_plural"] .ap-table-model tbody tr').length, count
  click '[data-t="resources.environment-variable_plural"] .ap-table-model tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    afterCount = Object.keys(server.db.environments[0].data).length
    assert.equal currentURL(), '/apis/1/environments/1/edit'
    assert.equal afterCount, count - 1
    assert.equal find('[data-t="resources.environment-variable_plural"] .ap-table-model tbody tr').length, count - 1
