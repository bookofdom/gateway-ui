`import BaseFormComponent from 'gateway/components/forms/base-form'`

PushChannelMessageFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'push-channel-message'

  defaultFields: [
    name: 'push_channel'
    type: 'select-model-name'
    label: 'resources.push-channel'
    required: true
  ,
    name: 'body'
    label: 'languages.json'
    type: 'json'
    required: true
  ]


`export default PushChannelMessageFormComponent`
