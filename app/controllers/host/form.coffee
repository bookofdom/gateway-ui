`import FormController from 'gateway/controllers/form'`

HostFormController = FormController.extend
  needs: ['hosts']
  modelType: 'host'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    hosts = @get 'controllers.hosts.model'
    hosts.pushObject newModel

`export default HostFormController`
