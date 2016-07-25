`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import InlineFormMixin from 'gateway/mixins/inline-form'`

StripeCardInlineFormComponent = BaseFormComponent.extend InlineFormMixin,
  modelType: 'stripe-card'
  ownerModel: null
  ownerFieldName: 'card'

  inline: false
  horizontal: true

  defaultFields: [
    name: 'number'
    label: 'fields.cc_number'
  ,
    name: 'exp_month'
    label: 'fields.cc_exp_month'
  ,
    name: 'exp_year'
    label: 'fields.cc_exp_year'
  ,
    name: 'cvc'
    label: 'fields.cc_cvc'
  ,
    name: 'address_zip'
    label: 'fields.cc_address_zip'
  ]

  createNewModel: ->
    modelType = @get 'modelType'
    ownerModel = @get 'ownerModel'
    ownerFieldName = @get 'ownerFieldName'
    newModel = @get('store')?.createRecord modelType
    ownerModel.set ownerFieldName, newModel
    @set 'model', newModel
    newModel

`export default StripeCardInlineFormComponent`
