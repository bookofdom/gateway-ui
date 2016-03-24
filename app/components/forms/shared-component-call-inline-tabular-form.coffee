`import SharedComponentCallInlineFormComponent from './shared-component-call-inline-form'`
`import InlineFormMixin from 'gateway/mixins/inline-form'`

SharedComponentCallInlineTabularFormComponent = SharedComponentCallInlineFormComponent.extend InlineFormMixin,
  fields: [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]

`export default SharedComponentCallInlineTabularFormComponent`
