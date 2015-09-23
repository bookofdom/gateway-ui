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
  resourceType: Ember.computed 'resource', ->
    @get('resource').dasherize()
  resourceIsLoaded: Ember.computed 'resourceType', 'resource_id', ->
    resourceType = @get 'resourceType'
    resourceId = @get 'resource_id'
    @store.hasRecordForId resourceType, resourceId
  resourceRecord: Ember.computed 'resourceType', 'resource_id', 'resourceIsLoaded', ->
    resourceType = @get 'resourceType'
    resourceId = @get 'resource_id'
    isLoaded = @get 'resourceIsLoaded'
    if isLoaded
      @store.find resourceType, resourceId
  message: Ember.computed 'resourceType', 'action', 'user', ->
    resourceType = @get 'resourceType'
    resourceRecord = @get 'resourceRecord'
    action = @get 'action'
    user = @get 'user'
    resourceTitle = t "resources.#{resourceType}"
    resourceName = resourceRecord?.get 'name'
    message = t "notifications.#{action}",
      user: user
      resource: resourceTitle
    message = "#{message} (\"#{resourceName}\")" if resourceName
    message

`export default Notification`
