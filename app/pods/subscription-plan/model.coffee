`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

SubscriptionPlan = Model.extend
  name: DS.attr 'string'
  stripe_name: DS.attr 'string'
  max_users: DS.attr 'number'
  javascript_timeout: DS.attr 'string'
  price: DS.attr 'number'

  # Computed
  isBillable: Ember.computed 'price', -> @get('price') > 0

`export default SubscriptionPlan`
