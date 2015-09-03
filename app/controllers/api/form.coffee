`import FormController from 'gateway/controllers/form'`

ApiFormController = FormController.extend
  modelType: 'api'
  fields: Ember.computed 'model.isNew', ->
    newFields = [
      name: 'name'
      required: true,
    ,
      name: 'export'
      label: 'fields.import'
      type: 'file'
    ]
    editFields = [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'cors_allow_origin'
    ,
      name: 'cors_allow_headers'
    ,
      name: 'cors_allow_credentials'
    ,
      name: 'cors_request_headers'
    ,
      name: 'cors_max_age'
      type: 'integer'
    ]
    if @get 'model.isNew' then newFields else editFields
  actions:
    afterDelete: ->
      @send 'deleted'

`export default ApiFormController`
