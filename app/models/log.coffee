`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'

  enableStreaming: ->
    adapter = @container.lookup 'adapter:log'
    adapter.enableStreaming @

`export default Log`
