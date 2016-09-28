`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'
  'tertiary-layout-header': Ember.computed 'model.name', ->
    t 'headers.x-workflow', x: @get 'model.name'

`export default ProxyEndpointController`
