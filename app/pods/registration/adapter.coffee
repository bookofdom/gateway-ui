`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import StripeCardAdapterMixin from 'gateway/mixins/stripe-card-adapter'`

RegistrationAdapter = ApplicationAdapter.extend StripeCardAdapterMixin

`export default RegistrationAdapter`
