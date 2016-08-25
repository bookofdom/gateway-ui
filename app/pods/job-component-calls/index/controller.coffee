`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponentCallsController = Ember.Controller.extend
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

`export default ProxyEndpointComponentCallsController`
