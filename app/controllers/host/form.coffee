`import FormController from 'gateway/controllers/form'`

HostFormController = FormController.extend
  hosts: Ember.inject.controller()
  modelType: 'host'
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'hostname'
      required: true
    ]
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        hosts = @get 'hosts.model'
        hosts.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default HostFormController`
