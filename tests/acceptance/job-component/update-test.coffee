`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Job Component - Update',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 32, apiId: api.id
      server.createList 'shared_component', 10, apiId: api.id
      server.createList('job', 1, apiId: api.id).forEach (job) ->
        server.createList 'job_component', 10, jobId: job.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to job components edit route', (assert) ->
  visit '/apis/1/jobs/1/edit'
  click '.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable):eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/components/1/edit'

test 'user can edit job components', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/jobs/1/components/1/edit'
      assert.equal server.db.jobs[0].components[0].conditional, 'foo("test");'
      done()
  server.put '/apis/:apiId/jobs/:id', makePutHandler('job', after)
  visit '/apis/1/jobs/1/components/1/edit'
  andThen ->
    findWithAssert('[data-t="fields.conditional"] .ap-ace-editor')[0].aceEditor.getSession().setValue 'foo("test");'
    click '[type=submit]'
