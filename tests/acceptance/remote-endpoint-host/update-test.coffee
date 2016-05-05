`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Remote Endpoint Host - Update',
  beforeEach: ->
    @application = startApp()
    apis = server.createList 'api', 1
    apis.forEach (api) -> server.createList 'remote_endpoint', 10, apiId: api.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can edit remote endpoint hosts', (assert) ->
  done = assert.async()
  remoteEndpoint = server.schema.remoteEndpoint.where(type: 'mongodb')[0]
  after = ->
    wait()
    andThen ->
      remoteEndpoint = server.schema.remoteEndpoint.where(type: 'mongodb')[0]
      assert.equal currentURL(), "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
      assert.equal remoteEndpoint.attrs.data.config.hosts.get('firstObject').host, 'foobars.com'
      done()
  server.put '/apis/:apiId/remote_endpoints/:id', makePutHandler('remote_endpoint', after)
  visit "/apis/1/remote-endpoints/#{remoteEndpoint.id}/edit"
  fillIn '.ap-panel-edit[data-t="resources.host_plural"] .ap-table-model tbody tr:eq(0) [name=host]', 'foobars.com'
  fillIn '.ap-panel-edit[data-t="resources.host_plural"] .ap-table-model tbody tr:eq(0) [name=port]', '1000000'
  click '[type=submit]'
