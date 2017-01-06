`import JobComponentCallInlineFormComponent from 'gateway-ui/pods/components/forms/job-component-call-inline-form/component'`
`import InlineFormMixin from 'gateway-ui/mixins/inline-form'`

JobComponentCallInlineTabularFormComponent = JobComponentCallInlineFormComponent.extend InlineFormMixin,
  fields: [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]

`export default JobComponentCallInlineTabularFormComponent`
