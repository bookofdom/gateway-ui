`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: Key - Create',
  beforeEach: ->
    @application = startApp()
    server.createList 'key', 5
    authenticateSession @application
    return

  afterEach: -> destroyApp @application

addFile = () ->
  blob = new Blob(["---TEST KEY---"], {type: 'text/plain'})
  blob.name = 'foobar.txt'

  fileInput = $('input[type=file]')

  fileInput.triggerHandler type:'change',
    target:
      files:
        0: blob,
        length: 1,
        item: -> return blob

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
  visit '/manage/keys'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/keys'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'Foobar'
  addFile()
  click '.ap-panel-new [type=submit]'
