`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: API - Read',
  beforeEach: ->
    @application = startApp()
    server.createList 'api', 1
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to APIs', (assert) ->
  visit '/'
  click '[data-t="nav.build"] a'
  andThen ->
    assert.equal currentURL(), '/apis'

test 'user can view APIs', (assert) ->
  count = server.db.apis.length
  visit '/apis'
  andThen ->
    assert.equal currentURL(), '/apis'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
