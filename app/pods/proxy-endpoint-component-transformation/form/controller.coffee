`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponentTransformationFormController = FormController.extend
  'api': Ember.inject.controller()
  before: false
  after: false
  'option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'
    type: [
      name: t('languages.javascript').capitalize()
      value: 'js'
    ]
  fields: Ember.computed 'model.before', 'model.after', ->
    typeLabel = 'fields.type'
    bodyLabel = 'fields.logic'
    if @get 'model.before'
      typeLabel = 'fields.before-type'
      bodyLabel = 'fields.before'
    if @get 'model.after'
      typeLabel = 'fields.after-type'
      bodyLabel = 'fields.after'
    [
      name: 'body'
      label: bodyLabel
      type: 'javascript'
    ]

`export default ProxyEndpointComponentTransformationFormController`
