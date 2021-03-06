`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

PushDevice = Model.extend
  name: DS.attr 'string'
  type: DS.attr 'string'
  token: DS.attr 'string'

`export default PushDevice`
