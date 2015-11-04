`import Ember from 'ember'`

ProxyEndpointsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint_plural'
  queryParams: ['environment_id', 'endpoint_group_id']

`export default ProxyEndpointsController`
