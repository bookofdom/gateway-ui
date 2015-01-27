`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EnvironmentsController = Ember.ArrayController.extend
  breadCrumb: t 'resources.environment_plural'

`export default EnvironmentsController`
