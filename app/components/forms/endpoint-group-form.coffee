`import BaseFormComponent from './base-form'`

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
