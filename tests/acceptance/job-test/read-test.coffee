`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Job Test - Read',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList('job', 1, apiId: api.id).forEach (j) ->
        server.createList 'job_test', 3, jobId: j.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to', (assert) ->
  visit '/apis/1/jobs/1'
  click '.ap-app-tertiary-sidebar [data-t="resources.job-test_plural"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/tests'

test 'user can view', (assert) ->
  visit '/apis/1/jobs/1/tests'
  andThen ->
    count = server.schema.job.all()[0].job_tests.length
    assert.equal currentURL(), '/apis/1/jobs/1/tests'
    assert.equal count > 0, true
    assert.equal find('.ap-table-auto-index tbody tr').length, count
