`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointsController = Ember.ArrayController.extend
  breadCrumb: t 'resources.remote-endpoint_plural'

`export default RemoteEndpointsController`
