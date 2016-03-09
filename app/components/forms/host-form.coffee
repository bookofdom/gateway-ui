`import BaseFormComponent from './base-form'`

HostFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'host'

  savedAction: null
  
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'hostname'
      required: true
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      hosts = @get 'indexModel'
      hosts.pushObject model
    @_super arguments...

`export default HostFormComponent`
