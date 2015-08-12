`import FormController from 'gateway/controllers/form'`

RemoteEndpointHostFormController = FormController.extend
  fields: Ember.computed ->
    [
      name: 'host'
      required: true
    ,
      name: 'port'
      type: 'integer'
      required: true
    ]

`export default RemoteEndpointHostFormController`
