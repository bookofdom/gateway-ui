`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

EndpointGroupFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'endpoint-group'

  savedAction: null

  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      endpointGroups = @get 'indexModel'
      endpointGroups.pushObject model
    @_super arguments...

`export default EndpointGroupFormComponent`
