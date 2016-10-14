`import { Model, belongsTo } from 'ember-cli-mirage'`

JobComponentModel = Model.extend
  job: belongsTo()

`export default JobComponentModel`
