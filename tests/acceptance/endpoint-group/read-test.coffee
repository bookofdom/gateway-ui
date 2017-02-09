`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Endpoint Group - Read',
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

test 'user can navigate to endpoint groups', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.endpoint-group_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/groups'

test 'user can view endpoint groups', (assert) ->
  visit '/apis/1/groups'
  andThen ->
    count = server.db.endpointGroups.length
    assert.equal currentURL(), '/apis/1/groups'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
