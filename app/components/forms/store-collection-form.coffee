`import BaseFormComponent from 'gateway/components/forms/base-form'`

StoreCollectionFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'store-collection'

  defaultFields: [
    name: 'name'
    required: true
  ]

`export default StoreCollectionFormComponent`
