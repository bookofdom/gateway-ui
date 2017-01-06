`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

JobComponentCallsIndexController = Ember.Controller.extend
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

`export default JobComponentCallsIndexController`
