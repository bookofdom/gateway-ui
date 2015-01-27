`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

EnvironmentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default EnvironmentController`
