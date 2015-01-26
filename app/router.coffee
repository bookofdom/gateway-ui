`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # development helpers
  @route 'component-reference', ->
    @route 'bootstrap'
    @route 'anypresence'
  
  # auth
  @route 'login'
  
  # resources
  @resource 'apis', ->
    @resource 'api', path: ':api_id', ->
      @route 'edit'
      @resource 'environments', ->
        @resource 'environment', path: ':environment_id', ->

`export default Router`
