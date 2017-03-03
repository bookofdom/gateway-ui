`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

HostFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'host'

  savedAction: null

  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'hostname'
      required: true
    ,
      name: 'force_ssl'
    ,
      name: 'private_key'
      type: 'file'
      help: 'fields.help.private_key'
    ,
      name: 'cert'
      type: 'file'
      help: 'fields.help.cert'
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      hosts = @get 'indexModel'
      hosts.pushObject model
    @_super arguments...

`export default HostFormComponent`
