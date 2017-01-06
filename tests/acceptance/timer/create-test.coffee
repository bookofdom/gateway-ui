`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Timer - Create',
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

test 'user can create new timers', (assert) ->
  beforeCreateCount = server.db.timers.length
  visit '/manage/job-schedules'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/job-schedules'
    assert.equal find('.ap-table-model tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New timer'
  andThen ->
    fillIn '[name=api]', find("[name=api] option:nth-child(2)").val()
  andThen ->
    fillIn '[name=job]', find("[name=job] option:nth-child(2)").val()
  click '.ap-panel-new [type=submit]'
  andThen ->
    assert.equal server.db.timers.length, beforeCreateCount + 1
    assert.equal find('.ap-table-model tbody tr').length, beforeCreateCount + 1
