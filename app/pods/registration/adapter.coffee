`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import StripeCardAdapterMixin from 'gateway-ui/mixins/stripe-card-adapter'`

RegistrationAdapter = ApplicationAdapter.extend StripeCardAdapterMixin

`export default RegistrationAdapter`
