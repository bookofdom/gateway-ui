`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Job Component - Delete',
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

test 'user can delete job components from edit route', (assert) ->
  visit '/apis/1/jobs/1/components/1/edit'
  andThen ->
    count = server.schema.job.all()[0].job_components.length
    assert.equal currentURL(), '/apis/1/jobs/1/components/1/edit'
    assert.equal count, 10
  click 'a[data-t="actions.delete"]'
  andThen ->
    # Notice the different attribute name for components?  That's because
    # for mock purposes, it's easier to have a dumb property for embedded data.
    # The mock backend doesn't use `components`, it just stores whatever
    # the client passes in.
    count = server.schema.job.all()[0].components.length
    assert.equal currentURL(), '/apis/1/jobs/1/edit'
    assert.equal count, 9
    assert.equal find('.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable)').length, 9
