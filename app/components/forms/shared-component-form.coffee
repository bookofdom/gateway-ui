`import BaseFormComponent from './base-form'`

SharedComponentFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'shared-component'

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/shared-component/#{type}-form"

  callsIndexModel: null
  'calls-option-groups': null
  'transformation-option-groups': null
  'option-groups': null

  newFields: [
    name: 'type'
    type: 'select'
  ,
    name: 'name'
  ,
    name: 'description'
    type: 'textarea'
  ]

  editFields: Ember.computed 'model.js', ->
    fields = [
      name: 'name'
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      type: 'javascript'
    ]
    if @get 'model.js'
      fields.push
        name: 'body'
        label: 'fields.logic'
        type: 'javascript'
    fields

  submit: ->
    model = @get 'model'
    store = @get 'store'
    if model.get 'isNew'
      # add to index model
      indexModel = @get 'indexModel'
      indexModel.pushObject model
      # setup embedded records
      if !model.get 'isJs'
        if model.get('single') and !model.get 'calls.length'
          newCall = store.createRecord 'shared-component-call'
          model.get('calls').pushObject newCall
        if !model.get 'before.length'
          newBefore = store.createRecord 'shared-component-transformation'
          model.get('before').pushObject newBefore
        if !model.get 'after.length'
          newAfter = store.createRecord 'shared-component-transformation'
          model.get('after').pushObject newAfter
        calls = @get 'indexModel'
        calls.pushObject model
    @_super.apply @, arguments

  createNewCallModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'shared-component-call'
    newBefore = @get('store').createRecord 'shared-component-transformation'
    newAfter = @get('store').createRecord 'shared-component-transformation'
    newModel.get('before').pushObject newBefore
    newModel.get('after').pushObject newAfter
    model.get('calls').pushObject newModel

  actions:
    'new-shared-component-call': (record) -> @createNewCallModel()
    'delete-shared-component-call': (record) -> record.deleteRecord()

`export default SharedComponentFormComponent`
