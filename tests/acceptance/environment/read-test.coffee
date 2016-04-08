`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Environment - Read',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'environment', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to environments', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.environment_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/environments'

test 'user can view environments', (assert) ->
  visit '/apis/1/environments'
  andThen ->
    count = server.db.environments.length
    assert.equal currentURL(), '/apis/1/environments'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
