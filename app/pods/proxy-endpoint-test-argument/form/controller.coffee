`import FormController from 'gateway/controllers/form'`

ProxyEndpointTestArgumentFormController = FormController.extend
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'value'
      required: true
    ]

`export default ProxyEndpointTestArgumentFormController`
