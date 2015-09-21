`import Ember from 'ember'`

formatDatetime = (params) ->
  # lll = localized month name, day, year, and time
  moment(params[0]).format 'lll'

FormatDatetimeHelper = Ember.Helper.helper formatDatetime

`export { formatDatetime }`

`export default FormatDatetimeHelper`
