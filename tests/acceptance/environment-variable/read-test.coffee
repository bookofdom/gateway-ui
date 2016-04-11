`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Environment Variable - Read',
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

test 'user can navigate to environment variables', (assert) ->
  visit '/apis/1/environments/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/environments/1/edit'

test 'user can view environment variables', (assert) ->
  visit '/apis/1/environments/1/edit'
  andThen ->
    # environment variables are represented as a JSON object in storage
    count = Object.keys(server.db.environments[0].data).length
    assert.equal currentURL(), '/apis/1/environments/1/edit'
    assert.equal count > 0, true
    assert.equal find('[data-t="resources.environment-variable_plural"] .ap-table-model tbody tr').length, count
