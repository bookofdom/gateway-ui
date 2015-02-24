`import FormController from 'gateway/controllers/form'`

HostFormController = FormController.extend
  needs: ['hosts']
  modelType: 'host'
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        hosts = @get 'controllers.hosts.model'
        hosts.pushObject model

`export default HostFormController`
