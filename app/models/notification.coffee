`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

Notification = DS.Model.extend
  resource: DS.attr 'string'
  resource_id: DS.attr 'number'
  api_id: DS.attr 'number'
  action: DS.attr 'string'
  user: DS.attr 'string'
  created: DS.attr 'date', defaultValue: -> Date.now()

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
      @store.peekRecord resourceType, resourceId
  message: Ember.computed 'resourceType', 'action', 'user', ->
    resourceType = @get 'resourceType'
    resourceRecord = @get 'resourceRecord'
    resourceTitle = t "resources.#{resourceType}"
    resourceName = resourceRecord?.get 'name'
    action = @get 'action'
    user = @get 'user'
    message = t "notifications.#{action}",
      user: user
      resource: resourceTitle
    message = message.toLowerCase()
    message = "#{message}:  \"#{resourceName}\"" if resourceName
    message

`export default Notification`
