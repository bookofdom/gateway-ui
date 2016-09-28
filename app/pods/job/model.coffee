`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Action from 'gateway/pods/action/model'`

Job = Action.extend
  # Relationships
  components: DS.hasMany 'job-component',
    async: false
    embeddedModel: true

`export default Job`
