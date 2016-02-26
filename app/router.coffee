`import Ember from 'ember'`
`import GooglePageviewMixin from './mixins/google-pageview'`
`import config from './config/environment'`

Router = Ember.Router.extend GooglePageviewMixin,
  location: config.locationType

Router.map ->
  # auth
  @route 'login'
  @route 'registration'
  @route 'password', ->
    @route 'reset'
    @route 'reset-confirmation'

  # resources
  @route 'users', resetNamespace: true, ->
    @route 'user', resetNamespace: true, path: ':user_id', ->
      @route 'edit'
  @route 'logs', resetNamespace: true, (->)
  @route 'apis', resetNamespace: true, ->
    @route 'api', resetNamespace: true, path: ':api_id', ->
      @route 'edit'
      @route 'proxy-endpoints', resetNamespace: true, ->
        @route 'proxy-endpoint', resetNamespace: true, path: ':proxy_endpoint_id', ->
          @route 'edit'
          @route 'proxy-endpoint-routes', resetNamespace: true, path: 'routes', ->
            @route 'proxy-endpoint-route', resetNamespace: true, path: ':proxy_endpoint_route_id', ->
              @route 'edit'
          @route 'proxy-endpoint-components', resetNamespace: true, path: 'components', ->
            @route 'new', ->
              @route 'type', path: ':proxy_endpoint_component_type'
            @route 'proxy-endpoint-component', resetNamespace: true, path: ':proxy_endpoint_component_id', ->
              @route 'edit'
              @route 'proxy-endpoint-component-calls', resetNamespace: true, path: 'calls', ->
                @route 'proxy-endpoint-component-call', resetNamespace: true, path: ':proxy_endpoint_component_call_id', ->
                  @route 'edit'
          @route 'proxy-endpoint-tests', resetNamespace: true, path: 'tests', ->
            @route 'proxy-endpoint-test', resetNamespace: true, path: ':proxy_endpoint_test_id', ->
              @route 'edit'
          @route 'proxy-endpoint-schemas', resetNamespace: true, path: 'schemas', ->
            @route 'proxy-endpoint-schema', resetNamespace: true, path: ':proxy_endpoint_schema_id', ->
              @route 'edit'
          @route 'logs-proxy-endpoint', resetNamespace: true, path: 'logs', (->)
      @route 'shared-components', resetNamespace: true, path: 'components', ->
        @route 'shared-component', resetNamespace: true, path: ':shared_component_id', ->
          @route 'edit'
          @route 'shared-component-calls', resetNamespace: true, path: 'calls', ->
            @route 'shared-component-call', resetNamespace: true, path: ':shared_component_call_id', ->
              @route 'edit'
      @route 'environments', resetNamespace: true, ->
        @route 'environment', resetNamespace: true, path: ':environment_id', ->
          @route 'edit'
      @route 'endpoint-groups', resetNamespace: true, path: 'groups', ->
        @route 'endpoint-group', resetNamespace: true, path: ':endpoint_group_id', ->
          @route 'edit'
      @route 'remote-endpoints', resetNamespace: true, ->
        @route 'remote-endpoint', resetNamespace: true, path: ':remote_endpoint_id', ->
          @route 'edit'
          @route 'remote-endpoint-environment-data', resetNamespace: true, path: 'environment-data', ->
            @route 'new'
            @route 'remote-endpoint-environment-datum', resetNamespace: true, path: ':remote_endpoint_environment_datum_id', ->
              @route 'edit'
      @route 'hosts', resetNamespace: true, ->
        @route 'host', resetNamespace: true, path: ':host_id', ->
          @route 'edit'
      @route 'libraries', resetNamespace: true, ->
        @route 'library', resetNamespace: true, path: ':library_id', ->
          @route 'edit'
      @route 'logs-api', resetNamespace: true, path: 'logs', (->)
      @route 'api-documentation', resetNamespace: true, path: 'api', ->
        @route 'api-documentation-detail', resetNamespace: true, path: ':host_id', (->)

`export default Router`
