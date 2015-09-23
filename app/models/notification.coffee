`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

Notification = DS.Model.extend
  resource: DS.attr 'string'
  resource_id: DS.attr 'number'
  api_id: DS.attr 'number'
  action: DS.attr 'string'
  user: DS.attr 'string'

  # Computed
  message: Ember.computed 'resource', 'action', 'user', ->
    resource = @get 'resource'
    action = @get 'action'
    user = @get 'user'
    resourceName = t "resources.#{resource.dasherize()}"
    t "notifications.#{action}",
      user: user
      resource: resourceName

`export default Notification`
