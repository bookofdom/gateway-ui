`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'

`export default Log`
