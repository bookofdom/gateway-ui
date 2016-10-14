`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Job - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'job', 1, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to jobs', (assert) ->
  visit '/apis/1/environments'
  click '.ap-app-secondary-sidebar [data-t="resources.job_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs'

test 'user can view jobs', (assert) ->
  visit '/apis/1/jobs'
  andThen ->
    count = server.db.jobs.length
    assert.equal currentURL(), '/apis/1/jobs'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
