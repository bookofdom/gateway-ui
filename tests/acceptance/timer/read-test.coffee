`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Timer - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 3).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'job', 3, apiId: api.id
    server.createList 'timer', 3
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can view timers', (assert) ->
  visit '/manage/timers'
  andThen ->
    count = server.db.timers.length
    assert.equal currentURL(), '/manage/timers'
    assert.equal count > 0, true
    assert.equal find('.ap-table-model tbody tr').length, count
