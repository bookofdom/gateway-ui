`import BaseFormComponent from './base-form'`

LibraryFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'library'

  'option-groups': null

  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'body'
      label: 'fields.logic'
      type: 'javascript-lg'
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      libraries = @get 'indexModel'
      libraries.pushObject model
    @_super.apply @, arguments

`export default LibraryFormComponent`
