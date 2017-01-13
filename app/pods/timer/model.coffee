`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

Timer = Model.extend
  name: DS.attr 'string'
  once: DS.attr 'boolean', defaultValue: false
  time_zone: DS.attr 'number', defaultValue: -5
  minute: DS.attr 'string', defaultValue: '0'
  hour: DS.attr 'string', defaultValue: '*'
  day_of_month: DS.attr 'string', defaultValue: '*'
  month: DS.attr 'string', defaultValue: '*'
  day_of_week: DS.attr 'string', defaultValue: '*'
  next: DS.attr 'string'
  parameters: DS.attr 'string', defaultValue: '{}'

  # Relationships
  api: DS.belongsTo 'api',
    async: false
    stains: true
  job: DS.belongsTo 'job',
    async: false
    stains: true

`export default Timer`
