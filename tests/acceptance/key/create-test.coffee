`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: Key - Create',
  beforeEach: ->
    @application = startApp()
    server.createList 'key', 5
    authenticateSession @application
    return

  afterEach: -> destroyApp @application

test 'admin can create new keys', (assert) ->
  done = assert.async()
  beforeCreateCount = server.db.keys.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.keys.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/keys', makePostHandler('key', after)
  visit '/account/keys'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/account/keys'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'Foobar'
  //TODO: Not sure how to mock this file handler.
  fillIn '[name=key]', 'data:text/plain;charset=utf-8;base64,aGV5YQ=='
  click '.ap-panel-new [type=submit]'
