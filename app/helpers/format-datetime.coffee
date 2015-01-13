`import Ember from 'ember'`

formatDatetime = (value) ->
  # lll = localized month name, day, year, and time
  moment(value).format 'lll'

FormatDatetimeHelper = Ember.Handlebars.makeBoundHelper formatDatetime

`export { formatDatetime }`

`export default FormatDatetimeHelper`
