`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Timer - Delete',
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

test 'user can delete timers from index route', (assert) ->
  visit '/manage/job-schedules'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules'
    assert.equal server.db.timers.length, 3
    assert.equal find('.ap-table-auto-index tbody tr').length, 3
  click '.ap-table-auto-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules'
    assert.equal server.db.timers.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2

test 'user can delete timers from edit route', (assert) ->
  visit '/manage/job-schedules/1/edit'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules/1/edit'
    assert.equal server.db.timers.length, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules'
    assert.equal server.db.timers.length, 2
    assert.equal find('.ap-table-auto-index tbody tr').length, 2
