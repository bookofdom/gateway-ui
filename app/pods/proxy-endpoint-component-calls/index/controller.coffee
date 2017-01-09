`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

ProxyEndpointComponentCallsController = Ember.Controller.extend
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

`export default ProxyEndpointComponentCallsController`
