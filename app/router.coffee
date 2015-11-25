`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # auth
  @route 'login'
  @route 'password', ->
    @route 'reset'
    @route 'reset-confirmation'

  # resources
  @resource 'users', ->
    @resource 'user', path: ':user_id', ->
      @route 'edit'
  @resource 'logs', (->)
  @resource 'apis', ->
    @resource 'api', path: ':api_id', ->
      @route 'edit'
      @resource 'proxy-endpoints', ->
        @resource 'proxy-endpoint', path: ':proxy_endpoint_id', ->
          @route 'edit'
          @resource 'proxy-endpoint-routes', path: 'routes', ->
            @resource 'proxy-endpoint-route', path: ':proxy_endpoint_route_id', ->
              @route 'edit'
          @resource 'proxy-endpoint-components', path: 'components', ->
            @route 'new', ->
              @route 'type', path: ':proxy_endpoint_component_type'
            @resource 'proxy-endpoint-component', path: ':proxy_endpoint_component_id', ->
              @route 'edit'
              @resource 'proxy-endpoint-component-calls', path: 'calls', ->
                @resource 'proxy-endpoint-component-call', path: ':proxy_endpoint_component_call_id', ->
                  @route 'edit'
          @resource 'proxy-endpoint-tests', path: 'tests', ->
            @resource 'proxy-endpoint-test', path: ':proxy_endpoint_test_id', ->
              @route 'edit'
          @resource 'logs-proxy-endpoint', path: 'logs', (->)
      @resource 'environments', ->
        @resource 'environment', path: ':environment_id', ->
          @route 'edit'
      @resource 'endpoint-groups', path: 'groups', ->
        @resource 'endpoint-group', path: ':endpoint_group_id', ->
          @route 'edit'
      @resource 'remote-endpoints', ->
        @resource 'remote-endpoint', path: ':remote_endpoint_id', ->
          @route 'edit'
          @resource 'remote-endpoint-environment-data', path: 'environment-data', ->
            @route 'new'
            @resource 'remote-endpoint-environment-datum', path: ':remote_endpoint_environment_datum_id', ->
              @route 'edit'
      @resource 'hosts', ->
        @resource 'host', path: ':host_id', ->
          @route 'edit'
      @resource 'libraries', ->
        @resource 'library', path: ':library_id', ->
          @route 'edit'
      @resource 'logs-api', path: 'logs', (->)

`export default Router`
