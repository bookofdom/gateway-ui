`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Job Test - Create',
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

test 'user can create on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.jobTests.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.jobTests.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/jobs/:jobId/tests', makePostChildHandler('job', 'job_test', after)
  visit '/apis/1/jobs/1/tests'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/jobs/1/tests'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New test'
  click '.ap-panel-new [type=submit]'
