`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'

  # search-related fields
  query: DS.attr 'string'
  start: DS.attr 'datetime'
  end: DS.attr 'datetime'
  limit: DS.attr 'number'

`export default Log`
