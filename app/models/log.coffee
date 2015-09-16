`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'

  pushLogLine: (line) ->
    body = @get 'body'
    body = [body, line].join ''
    @set 'body', body

  enableStreaming: ->
    adapter = @container.lookup 'adapter:log'
    adapter.enableStreaming @

`export default Log`
