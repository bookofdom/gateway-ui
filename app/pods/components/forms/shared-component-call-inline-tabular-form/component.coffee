`import SharedComponentCallInlineFormComponent from 'gateway-ui/pods/components/forms/shared-component-call-inline-form/component'`
`import InlineFormMixin from 'gateway-ui/mixins/inline-form'`

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
