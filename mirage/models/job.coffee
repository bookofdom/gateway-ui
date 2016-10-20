`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

JobModel = Model.extend
  api: belongsTo()
  job_components: hasMany()

`export default JobModel`
