`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePutHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Push Device - Update',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 5).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
    server.createList('push_device', 5)
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can navigate to push devices edit route', (assert) ->
  visit '/manage/push/devices'
  click '.ap-table-model tbody tr:eq(0) [data-t="actions.edit"] a'
  andThen ->
    assert.equal currentURL(), '/manage/push/devices/1/edit'

test 'user can edit push devices', (assert) ->
  visit '/manage/push/devices/1/edit'
  fillIn '[name=name]', 'Test'
  click '[type=submit]'
  andThen ->
    assert.equal currentURL(), '/manage/push/devices/1/edit'
    assert.equal server.db.pushDevices[0].name, 'Test'
