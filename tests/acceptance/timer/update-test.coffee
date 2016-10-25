`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Timer - Update',
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

test 'user can navigate to timers edit route', (assert) ->
  visit '/manage/job-schedules'
  click '.ap-table-model tbody tr:eq(0) [data-t="actions.edit"] a'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules/1/edit'

test 'user can edit timers', (assert) ->
  visit '/manage/job-schedules/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/manage/job-schedules/1/edit'
    assert.equal server.db.timers[0].name, 'Test'
