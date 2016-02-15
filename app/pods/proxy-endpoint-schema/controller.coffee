`import Ember from 'ember'`

ProxyEndpointSchemaController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ProxyEndpointSchemaController`
