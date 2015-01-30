`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'
  'tertiary-layout-header': Ember.computed ->
    t 'headers.x-workflow', x: @get 'name'

`export default ProxyEndpointController`
