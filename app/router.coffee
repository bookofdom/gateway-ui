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
          @route 'edit'
      @resource 'endpoint-groups', path: 'groups', ->
        @resource 'endpoint-group', path: ':endpoint_group_id', ->
          @route 'edit'

`export default Router`
