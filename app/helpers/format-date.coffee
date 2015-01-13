`import Ember from 'ember'`

formatDate = (value) ->
  # ll = localized month name, day, year
  moment(value).format 'll'

FormatDateHelper = Ember.Handlebars.makeBoundHelper formatDate

`export { formatDate }`

`export default FormatDateHelper`
