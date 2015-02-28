`import FormController from 'gateway/controllers/form'`

ApiFormController = FormController.extend
  modelType: 'api'
  fields: Ember.computed 'isNew', ->
    baseFields = 'name,description:::textarea'
    if @get 'isNew'
      baseFields
    else
      "#{baseFields},cors_allow_origin,cors_allow_headers,cors_allow_credentials,cors_request_headers,cors_max_age:::integer"

`export default ApiFormController`
