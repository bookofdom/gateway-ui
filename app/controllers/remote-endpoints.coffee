`import Ember from 'ember'`

RemoteEndpointsController = Ember.Controller.extend
  breadCrumb: 'resources.remote-endpoint_plural'
  queryParams: ['type']

`export default RemoteEndpointsController`
