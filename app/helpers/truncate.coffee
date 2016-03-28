`import Ember from 'ember'`

truncate = (params, options) ->
  limit = options.limit or 35
  value = params[0] or ''
  value.substring 0, limit

TruncateHelper = Ember.Helper.helper truncate

`export { truncate }`
`export default TruncateHelper`
