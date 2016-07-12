`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Push Device - Create',
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

test 'user can create new push devices', (assert) ->
  beforeCreateCount = server.db.pushDevices.length
  visit '/manage/push/devices'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/push/devices'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New push device'
  andThen ->
    fillIn '[name=type]', find("[name=type] option:nth-child(2)").val()
  fillIn '[name=token]', 'abc123'
  fillIn '[name=expires]', '2016-05-31T00:00:00Z'
  click '.ap-panel-new [type=submit]'
  andThen ->
    assert.equal server.db.pushDevices.length, beforeCreateCount + 1
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
