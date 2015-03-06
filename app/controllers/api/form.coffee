`import FormController from 'gateway/controllers/form'`

ApiFormController = FormController.extend
  modelType: 'api'
  fields: Ember.computed 'isNew', ->
    newFields = [
      name: 'name'
      required: true
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
    if @get 'isNew' then newFields else editFields

`export default ApiFormController`
