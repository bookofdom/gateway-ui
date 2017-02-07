`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

# Represents a REPL session
ReplSession = DS.Model.extend
  created: DS.attr 'date', defaultValue: -> Date.now()
  input: DS.attr 'string'
  output: DS.attr 'string'

  bufferOutput: (output) ->
    console.log output

`export default ReplSession`
