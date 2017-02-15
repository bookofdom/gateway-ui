`import Ember from 'ember'`

ProxyEndpointController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ProxyEndpointController`
