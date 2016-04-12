`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Remote Endpoint - Read',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to remote endpoints', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.remote-endpoint_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/remote-endpoints'

test 'user can view remote endpoints', (assert) ->
  visit '/apis/1/remote-endpoints'
  andThen ->
    count = server.db.remoteEndpoints.length
    assert.equal currentURL(), '/apis/1/remote-endpoints'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
