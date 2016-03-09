`import BaseFormComponent from 'gateway/components/forms/base-form'`

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
    @_super.apply @, arguments

`export default EndpointGroupFormComponent`
