`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import storeScenario from 'gateway/mirage/scenarios/store'`

module 'Acceptance: Store Collection - Index',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'collections index redirects to new collection when no collections exist yet', (assert) ->
  authenticateSession @application
  visit '/collections/'
  andThen ->
    assert.equal currentURL(), '/collections/new'

test 'collections index redirects to first collection\'s objects index', (assert) ->
  storeScenario server
  authenticateSession @application
  visit '/collections/'
  andThen ->
    assert.equal currentURL(), '/collections/1/objects'

test 'user can navigate to store collections', (assert) ->
  storeScenario server
  authenticateSession @application
  visit '/'
  click '[data-t="nav.manage-store"] a'
  andThen ->
    assert.equal currentURL(), '/collections/1/objects'

test 'user can navigate among store collections\' objects index routes', (assert) ->
  storeScenario server
  authenticateSession @application
  visit '/collections/1/objects'
  click '.ap-app-secondary-sidebar > .ap-list-nav li:eq(1) a'
  andThen ->
    assert.equal currentURL(), '/collections/2/objects'
  click '.ap-app-secondary-sidebar > .ap-list-nav li:eq(2) a'
  andThen ->
    assert.equal currentURL(), '/collections/3/objects'
