`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Stats Query - Read',
  beforeEach: ->
    @application = startApp()
    authenticateSession @application
    collections = server.createList 'stat', 10
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'stats queries route redirects to first stats query', (assert) ->
  visit '/analyze/stats'
  andThen ->
    assert.equal currentURL(), '/analyze/stats/response-time'

test 'user can navigate to stats queries', (assert) ->
  visit '/'
  click '[data-t="nav.analyze"] a'
  andThen ->
    assert.equal currentURL(), '/analyze/stats/response-time'

test 'user can navigate among stats queries', (assert) ->
  visit '/analyze/stats'
  click '.ap-app-secondary-sidebar li:eq(1) a'
  andThen ->
    assert.equal currentURL(), '/analyze/stats/average-speed'
  click '.ap-app-secondary-sidebar li:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/analyze/stats/response-time'
