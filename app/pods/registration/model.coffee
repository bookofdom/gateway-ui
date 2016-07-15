`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'
  plan: DS.attr 'string', defaultValue: 'cloud-free-0'

# Declare available plans and their human-readable names
plans = 'cloud-free-0 cloud-hosted-0'.split(' ').map (type) ->
  name: t "types.registration.plans.#{type}"
  slug: type
  value: type

Registration.reopenClass
  plans: plans

`export default Registration`
