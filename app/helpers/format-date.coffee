`import Ember from 'ember'`

formatDate = (params) ->
  # ll = localized month name, day, year
  moment(params[0]).format 'll'

FormatDateHelper = Ember.Helper.helper formatDate

`export { formatDate }`

`export default FormatDateHelper`
