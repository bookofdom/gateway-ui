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
    # don't show the `type` field for now, since there is only one option
    #"type:#{typeLabel}::select,body:#{bodyLabel}::javascript"
    "body:#{bodyLabel}::javascript"

`export default ProxyEndpointComponentTransformationFormController`
