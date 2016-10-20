`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostChildHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Job - Create',
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

test 'user can create new jobs on index', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.jobs.length
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/jobs/2/edit'
      afterCreateCount = server.db.jobs.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      done()
  server.post '/apis/:apiId/jobs', makePostChildHandler('api', 'job', after)
  visit '/apis/1/jobs'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis/1/jobs'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New job'
  click '.ap-panel-new [type=submit]'
