`import { timezones } from 'gateway/helpers/timezones'`
`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

TimerFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'timer'
  apis: null

  'option-groups': Ember.computed 'apis.[]', 'model.api', 'model.api.jobs.[]', ->
    api: @get('apis')?.filterBy 'isNew', false
    job: @get('model.api.jobs')?.filterBy 'isNew', false
    time_zone: timezones()

  newFields: [
      name: 'name'
      required: true
    ,
      name: 'api'
      type: 'select-model-name'
      label: 'resources.api'
      required: true
    ,
      name: 'job'
      type: 'select-model-name'
      label: 'resources.job'
      required: true
  ]

  editFields: Ember.computed 'model.once', ->
    fields = [
        name: 'name'
        required: true
      ,
        name: 'api'
        type: 'select-model-name'
        label: 'resources.api'
        required: true
      ,
        name: 'job'
        type: 'select-model-name'
        label: 'resources.job'
        required: true
      ,
        name: 'once'
    ]
    if @get 'model.once'
      fields.pushObjects [
        name: 'next'
        type: 'datetime'
        required: true
      ]
    else
      fields.pushObjects [
        name: 'time_zone'
        type: 'select'
        required: true
      ,
        name: 'minute'
        required: true
      ,
        name: 'hour'
        required: true
      ,
        name: 'day_of_month'
        required: true
      ,
        name: 'month'
        required: true
      ,
        name: 'day_of_week'
        required: true
      ]
    fields.pushObjects [
      name: 'parameters'
      type: 'json'
      required: true
    ]
    fields


`export default TimerFormComponent`
