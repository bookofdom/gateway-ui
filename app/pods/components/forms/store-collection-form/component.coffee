`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

StoreCollectionFormComponent = BaseFormComponent.extend
  modelType: 'store-collection'

  defaultFields: [
    name: 'name'
    required: true
  ]

`export default StoreCollectionFormComponent`
