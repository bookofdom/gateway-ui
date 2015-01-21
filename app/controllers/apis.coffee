`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

ApisController = Ember.ArrayController.extend
  breadCrumb: t 'resources.api_plural'

`export default ApisController`
