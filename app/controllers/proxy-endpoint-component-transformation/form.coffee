`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponentTransformationFormController = FormController.extend
  before: false
  after: false
  'option-groups':
    type: [
      name: t('languages.javascript').capitalize()
      value: 'js'
    ]
  fields: Ember.computed 'before', 'after', ->
    typeLabel = 'fields.type'
    bodyLabel = 'fields.logic'
    if @get 'before'
      typeLabel = 'fields.before-type'
      bodyLabel = 'fields.before'
    if @get 'after'
      typeLabel = 'fields.after-type'
      bodyLabel = 'fields.after'
    [
      name: 'body'
      label: bodyLabel
      type: 'javascript'
    ]

`export default ProxyEndpointComponentTransformationFormController`
