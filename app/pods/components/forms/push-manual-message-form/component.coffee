`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

PushManualMessageFormComponent = BaseFormComponent.extend
  modelType: 'push-manual-message'
  'push-channel': null

  'option-groups': Ember.computed 'push-channel.api.environments.[]', ->
    environment:
      @get('push-channel.api.environments').map (environment) ->
        name: environment.get 'name'
        value: environment.get 'name'

  defaultFields: [
      name: 'environment'
      type: 'select'
      label: 'resources.environment'
      required: true
    ,
      name: 'body'
      label: 'languages.json'
      type: 'json'
      required: true
  ]

  submit: ->
    model = @get 'model'
    push_channel = @get 'push-channel'
    model.set 'push_channel', push_channel
    model.save().finally =>
      if !model.get 'errors.messages.length'
        @createNewModel()
        @sendAction 'savedAction'
    false

`export default PushManualMessageFormComponent`
