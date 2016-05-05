`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Shared Component - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList 'shared_component', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to index', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.shared-component_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/components'

test 'user can view', (assert) ->
  visit '/apis/1/components'
  andThen ->
    count = server.db.sharedComponents.length
    assert.equal currentURL(), '/apis/1/components'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
