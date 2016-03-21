`import Ember from 'ember'`

stringify = (params) ->
  value = params[0]
  show = !Ember.isNone(value) or (value is null)
  JSON.stringify value if show

StringifyHelper = Ember.Helper.helper stringify

`export { stringify }`
`export default StringifyHelper`
