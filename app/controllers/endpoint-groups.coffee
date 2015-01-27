`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EndpointGroupsController = Ember.ArrayController.extend
  breadCrumb: t 'resources.endpoint-group_plural'

`export default EndpointGroupsController`
