`import Ember from 'ember'`
`import ApIconComponent from 'gateway/pods/components/ap-icon/component'`

ApPaymentIconComponent = ApIconComponent.extend
  classNames: ['ap-payment-icon']
  provider: null # e.g. visa, mastercard, amex, discover, diners, jcb
  icon: Ember.computed 'provider', ->
    provider = @get 'provider'
    "payment-#{provider}" if provider

`export default ApPaymentIconComponent`
