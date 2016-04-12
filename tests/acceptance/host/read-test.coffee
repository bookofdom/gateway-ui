`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Host - Read',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'host', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to hosts', (assert) ->
  visit '/apis/1/hosts'
  click '.ap-app-secondary-sidebar [data-t="resources.host_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/hosts'

test 'user can view hosts', (assert) ->
  visit '/apis/1/hosts'
  andThen ->
    count = server.db.hosts.length
    assert.equal currentURL(), '/apis/1/hosts'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
