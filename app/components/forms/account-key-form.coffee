`import BaseRemoteEndpointFormComponent from 'gateway/components/forms/base-remote-endpoint-form'`

AccountKeyFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null
  modelType: 'account-key'

  defaultFields: [
    name: 'name'
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      indexModel.pushObject model
    @_super arguments...

  actions:
    saved: ->
      @notifySaveSuccess()
      # resend this action
      # so that the router can handle it if necessary
      @sendAction 'savedAction'

`export default AccountKeyFormComponent`
