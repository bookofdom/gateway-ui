`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import defaultScenario from 'gateway/mirage/scenarios/default'`

module 'Acceptance: API - Read',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to APIs', (assert) ->
  defaultScenario server
  authenticateSession @application
  visit '/'
  click '[data-t="nav.define-api_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis'

test 'user can view APIs', (assert) ->
  defaultScenario server
  authenticateSession @application
  count = server.db.apis.length
  visit '/apis'
  andThen ->
    assert.equal currentURL(), '/apis'
    assert.equal count > 0, true
    assert.equal find('.ap-table-index tbody tr').length, count
