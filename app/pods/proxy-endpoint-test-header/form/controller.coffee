`import FormController from 'gateway/controllers/form'`

ProxyEndpointTestHeaderFormController = FormController.extend
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'value'
      required: true
    ]

`export default ProxyEndpointTestHeaderFormController`
