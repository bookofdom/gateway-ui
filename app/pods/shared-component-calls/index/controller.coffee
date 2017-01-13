`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

SharedComponentCallsController = Ember.Controller.extend
  'shared-component': Ember.inject.controller()
  'shared-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'shared-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'shared-component-calls.option-groups'
  'transformation-option-groups': Ember.computed.alias 'shared-component-calls.transformation-option-groups'

`export default SharedComponentCallsController`
