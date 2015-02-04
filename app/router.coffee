`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # auth
  @route 'login'
  
  # resources
  @resource 'apis', ->
    @resource 'api', path: ':api_id', ->
      @route 'edit'
      @resource 'proxy-endpoints', ->
        @resource 'proxy-endpoint', path: ':proxy_endpoint_id', ->
          @route 'edit'
          @resource 'proxy-endpoint-routes', path: 'routes', ->
            @resource 'proxy-endpoint-route', path: ':proxy_endpoint_route_id', ->
              @route 'edit'
      @resource 'environments', ->
        @resource 'environment', path: ':environment_id', ->
          @route 'edit'
      @resource 'endpoint-groups', path: 'groups', ->
        @resource 'endpoint-group', path: ':endpoint_group_id', ->
          @route 'edit'
      @resource 'remote-endpoints', ->
        @resource 'remote-endpoint', path: ':remote_endpoint_id', ->
          @route 'edit'
  
  # development helpers
  @route 'component-reference', ->
    @route 'bootstrap'
    @route 'anypresence'

`export default Router`
