`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Job - Update',
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

test 'user can navigate to jobs edit route', (assert) ->
  visit '/apis/1/jobs'
  click '.ap-table-auto-index tbody tr:eq(0) td:eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/edit'

test 'user can edit jobs', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/jobs/1/edit'
      assert.equal server.db.jobs[0].name, 'Test'
      done()
  server.put '/apis/:apiId/jobs/:id', makePutHandler('job', after)
  visit '/apis/1/jobs/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
