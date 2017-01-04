`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Library - Read',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'library', 3, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to libraries', (assert) ->
  visit '/apis/1/hosts'
  click '.ap-app-secondary-sidebar [data-t="resources.library_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/libraries'

test 'user can view libraries', (assert) ->
  visit '/apis/1/libraries'
  andThen ->
    count = server.db.libraries.length
    assert.equal currentURL(), '/apis/1/libraries'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
