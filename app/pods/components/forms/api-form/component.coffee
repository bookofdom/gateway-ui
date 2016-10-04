`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

ApiFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'api'

  newFields: [
      name: 'name'
      required: true,
    ,
      name: 'export'
      label: 'fields.import'
      type: 'file'
  ]
  editFields: [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'cors_allow_origin'
    ,
      name: 'cors_allow_headers'
    ,
      name: 'cors_allow_credentials'
    ,
      name: 'cors_request_headers'
    ,
      name: 'cors_max_age'
      type: 'integer'
    ,
      name: 'enable_swagger'
  ]

`export default ApiFormComponent`
