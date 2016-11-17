`import { Model, belongsTo } from 'ember-cli-mirage'`

JobTestModel = Model.extend
  job: belongsTo()

`export default JobTestModel`
