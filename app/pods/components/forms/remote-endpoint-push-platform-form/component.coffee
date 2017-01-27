`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import RemoteEndpointPushPlatform from 'gateway-ui/pods/remote-endpoint-push-platform/model'`

RemoteEndpointPushPlatformFormComponent = BaseFormComponent.extend
  parentModel: null
  indexModel: null
  modelType: 'remote-endpoint-push-platform'

  'option-groups':
    type: RemoteEndpointPushPlatform.types

  defaultFields:
    [
      name: 'name'
      required: true
    ,
      name: 'codename'
      required: true
    ,
      name: 'type'
      required: true
      type: 'select-name-key'
    ]

  platformFields:
    osx: [
      name: 'certificate'
      type: 'file'
      required: true
    ,
      name: 'password'
      type: 'password'
    ,
      name: 'topic'
    ,
      name: 'development'
    ]
    ios: [
      name: 'certificate'
      type: 'file'
      required: true
    ,
      name: 'password'
      type: 'password'
    ,
      name: 'topic'
      required: true
    ,
      name: 'development'
    ]
    gcm: [
      name: 'api_key'
      required: true
    ]
    fcm: [
      name: 'api_key'
      required: true
    ]
    mqtt: [
      name: 'password'
      type: 'password'
    ,
      name: 'connect_timeout'
      type: 'integer'
      required: true
    ,
      name: 'ack_timeout'
      type: 'integer'
      required: true
    ,
      name: 'timeout_retries'
      type: 'integer'
      required: true
    ]

  # Services
  session: Ember.inject.service()

  # Computed
  username: Ember.computed 'session.session.authenticated.email', 'model.codename',
  'model.remote_endpoint', 'model.environment_datum', 'model.environment_datum.remote_endpoint',
  'parentModel', 'parentModel.remote_endpoint', ->
    email = @get 'session.session.authenticated.email'
    remoteEndpoint = @get('model.remote_endpoint') ||
      @get('model.environment_datum.remote_endpoint') ||
      @get('parentModel.remote_endpoint') ||
      @get('parentModel')
    apiName = remoteEndpoint.get 'api.name'
    remoteEndpointCodename = remoteEndpoint.get 'codename'
    codename = @get('model.codename') || ""
    username = "#{email},#{apiName},#{remoteEndpointCodename},#{codename}"
    environment = @get('model.environment_datum') || @get('parentModel')
    environment_name = environment?.get('environment.name')
    username = "#{username},#{environment_name}" if environment_name?
    username

  isMQTT: Ember.computed 'model.type', ->
    @get('model.type') == 'mqtt'

  fields: Ember.computed 'model.type', ->
    fields = @_super arguments...
    type = @get 'model.type'
    platformFields = @get "platformFields.#{type}"
    fields = Ember.copy(fields).pushObjects platformFields if platformFields
    fields

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pushPlatforms = @get 'indexModel'
      pushPlatforms.pushObject model
    @_super arguments...

  actions:
    cancel: ->
      @get('model').cancel().then =>
        @sendAction 'canceledAction'

`export default RemoteEndpointPushPlatformFormComponent`
