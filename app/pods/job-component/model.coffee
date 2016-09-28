`import DS from 'ember-data'`
`import ActionComponent from 'gateway/pods/action-component/model'`

JobComponent = ActionComponent.extend
  # Relationships
  job: DS.belongsTo 'job', async: false
  calls: DS.hasMany 'job-component-call',
    async: false
    stains: true
    embeddedModel: true
  before: DS.hasMany 'job-component-transformation',
    async: false
    stains: true
    embeddedModel: true
  after: DS.hasMany 'job-component-transformation',
    async: false
    stains: true
    embeddedModel: true

`export default JobComponent`
