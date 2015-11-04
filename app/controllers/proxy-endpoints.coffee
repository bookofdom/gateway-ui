`import Ember from 'ember'`

ProxyEndpointsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint_plural'
  queryParams: ['environment_id']

`export default ProxyEndpointsController`
