`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Job Component - Create',
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

test 'user can create job components', (assert) ->
  done = assert.async()
  beforeCount = server.schema.job.all()[0].job_components.length
  after = ->
    wait()
    andThen ->
      count = server.schema.job.all()[0].components.length
      assert.equal !!currentURL().toString().match(/\/apis\/1\/jobs\/1\/components\/.*\/edit/), true
      assert.equal count, beforeCount + 1
      assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, beforeCount + 1
      done()
  server.put '/apis/:apiId/jobs/:id', makePutHandler('job', after)
  visit '/apis/1/jobs/1/edit'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/edit'
    assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, beforeCount

  click '.ap-app-tertiary-sidebar .ap-list-nav:eq(0) [data-t="actions.new"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/components/new'
  click '[data-t="actions.select-add-component-type"] [data-t="types.proxy-endpoint-component.js"] a'
  andThen ->
    assert.equal currentURL(), '/apis/1/jobs/1/components/new/js'
  click '[type=submit]'
