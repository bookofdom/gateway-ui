`import Ember from 'ember'`

TimersIndexController = Ember.Controller.extend
  'timers': Ember.inject.controller()
  'apis': Ember.computed.alias 'timers.apis'

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'next'
    label: 'fields.next'
    type: 'datetime'
  ,
    name: 'api.name'
    label: 'fields.api.name'
    type: 'string'
  ,
    name: 'job.name'
    label: 'fields.job.name'
    type: 'string'
  ]

`export default TimersIndexController`
