`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Proxy Endpoint Component - Update',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 26, apiId: api.id
      server.createList 'shared_component', 10, apiId: api.id
      server.createList('proxy_endpoint', 1, apiId: api.id).forEach (pe) ->
        server.createList 'proxy_endpoint_component', 10, proxyEndpointId: pe.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to proxy endpoint componentss edit route', (assert) ->
  visit '/apis/1/proxy-endpoints/1/edit'
  click '.ap-app-tertiary-sidebar .ap-list-nav:eq(0) li:not(.ap-unsortable):eq(0) a'
  andThen ->
    assert.equal currentURL(), '/apis/1/proxy-endpoints/1/components/1/edit'

test 'user can edit proxy endpoint components', (assert) ->
  done = assert.async()
  after = ->
    wait()
    andThen ->
      assert.equal currentURL(), '/apis/1/proxy-endpoints/1/components/1/edit'
      assert.equal server.db.proxyEndpoints[0].components[0].conditional, 'foo("test");'
      done()
  server.put '/apis/:apiId/proxy_endpoints/:id', makePutHandler('proxy_endpoint', after)
  visit '/apis/1/proxy-endpoints/1/components/1/edit'
  andThen ->
    findWithAssert('[data-t="fields.conditional"] .ap-ace-editor')[0].aceEditor.getSession().setValue 'foo("test");'
    click '[type=submit]'
