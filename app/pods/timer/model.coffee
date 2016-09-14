`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

Timer = Model.extend
  name: DS.attr 'string'
  once: DS.attr 'boolean'
  time_zone: DS.attr 'number'
  minute: DS.attr 'string'
  hour: DS.attr 'string'
  day_of_month: DS.attr 'string'
  month: DS.attr 'string'
  day_of_week: DS.attr 'string'
  next: DS.attr 'string'
  attributes: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api',
    async: false
    stains: true
  job: DS.belongsTo 'job',
    async: false
    stains: true

`export default Timer`
