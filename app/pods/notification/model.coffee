`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

Notification = DS.Model.extend
  resource: DS.attr 'string'
  resource_id: DS.attr 'number'
  api_id: DS.attr 'number'
  action: DS.attr 'string'
  tag: DS.attr 'string'
  user: DS.attr 'string'
  created: DS.attr 'date', defaultValue: -> Date.now()

  # Computed
  resourceType: Ember.computed 'resource', ->
    @get('resource')?.dasherize()
  resourceIsLoaded: Ember.computed 'resourceType', 'resource_id', ->
    resourceType = @get 'resourceType'
    resourceId = @get 'resource_id'
    if resourceType
      @store.hasRecordForId resourceType, resourceId
  resourceRecord: Ember.computed 'resourceType', 'resource_id', 'resourceIsLoaded', ->
    resourceType = @get 'resourceType'
    resourceId = @get 'resource_id'
    isLoaded = @get 'resourceIsLoaded'
    if isLoaded
      @store.peekRecord resourceType, resourceId
  resourceTitleKey: Ember.computed 'resourceType', ->
    resourceType = @get 'resourceType'
    "$t(resources.#{resourceType})"
  resourceName: Ember.computed.alias 'resourceRecord.name'
  messageKey: Ember.computed 'action', 'tag', ->
    action = @get 'action'
    action = 'import' if @get('tag') is 'import'
    "notifications.#{action}"
  isCreated: Ember.computed 'action', -> @get('action') is 'create'
  isUpdated: Ember.computed 'action', -> @get('action') is 'update'
  isDeleted: Ember.computed 'action', -> @get('action') is 'delete'
  isDisplayed: Ember.computed 'tag', 'resource', ->
    @get('tag') isnt 'import' or @get('resource') is 'api'

  # Give the resource a reference to this notification.
  # Overwrite whatever was there previously, since notifications are meant
  # to be transient.
  onInit: Ember.on 'init', ->
    resourceRecord = @get 'resourceRecord'
    resourceRecord?.set 'notification', @

`export default Notification`
