`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

Plan = Model.extend
  name: DS.attr 'string'
  stripe_name: DS.attr 'string'
  max_users: DS.attr 'number'
  javascript_timeout: DS.attr 'string'
  job_timeout: DS.attr 'string'
  price: DS.attr 'number', defaultValue: 0 # cents

  # Computed
  isBillable: Ember.computed 'price', -> @get('price') > 0
  dollars: Ember.computed 'price', -> @get('price') / 100 # price is in cents

`export default Plan`
