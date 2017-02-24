`import Ember from 'ember'`
`import { Response } from 'ember-cli-mirage'`
`import { makePostHandler, makePutHandler, makeGetChildrenHandler, makePostChildHandler, getChildren } from './helpers/route-handlers'`

config = ->
  @passthrough()
  @passthrough('https://checkout.stripe.com/api/outer/manhattan')

  # @urlPrefix = '';    # make this `http://localhost:8080`, for example, if your API is on a different server
  @namespace = 'admin';    # make this `api`, for example, if your API is namespaced
  # @timing = 400;      # delay for each request, automatically set to 0 during testing

  @get '/ap-request.js', ->
    new Response 200, {'Content-Type': 'text/javascript'}, '''
      /**
      * Mock ap-request.js file.
      * @param {string} ap - ap
      * @param {string} request - request
      */
      function apRequestJs (name, doc) {};
    '''

  # info
  @get '/info', (schema, request) ->
    info: schema.db.infos
  @get '/info/:id'

  # sessions
  @post '/sessions', (schema, request) ->
    body = JSON.parse request.requestBody
    session = schema.session.all().toArray().find (session) ->
      (session.user.email == body.email) and
        (session.user.password == body.password)
    if !session
      new Response 400, {}, error: 'Login failed.'
    else
      user: session.user
  @delete '/sessions', -> new Response 200

  # plans
  @get '/plans'

  # logs
  @get '/logs', (schema, request) -> schema.log.all()[0]
  @get '/apis/:apiId/logs', (schema, request) -> schema.log.all()[0]
  @get '/apis/:apiId/proxy_endpoints/:proxyEndpointId/logs', (schema, request) -> schema.log.all()[0]

  # registrations is a dumb endpoint... it just returns the posted payload
  @post '/registrations', (schema, request) -> JSON.parse request.requestBody
  @post '/registration_confirmation', -> new Response 200

  # password resets are dumb endpoints
  @post '/password_reset', -> new Response 200
  @post '/password_reset_confirmation', -> new Response 200

  @get '/push_channels'
  @post '/push_channels', makePostHandler 'push_channel'
  @get '/push_channels/:id'
  @put '/push_channels/:id', makePutHandler 'push_channel'
  @del '/push_channels/:id'

  @post '/push_channels/:id/push_manual_messages', -> new Response 200

  @get '/push_devices'
  @post '/push_devices', makePostHandler 'push_device'
  @get '/push_devices/:id'
  @put '/push_devices/:id', makePutHandler 'push_device'
  @del '/push_devices/:id'

  @get '/push_channel_messages'

  @get '/push_channels/:pushChannelId/push_devices', makeGetChildrenHandler('push_channel', 'push_device')
  @post '/push_channels/:pushChannelId/push_devices', makePostChildHandler('push_channel', 'push_device')
  @get '/push_channels/:pushChannelId/push_devices/:id'
  @put '/push_channels/:pushChannelId/push_devices/:id', makePutHandler 'push_device'
  @del '/push_channels/:pushChannelId/push_devices/:id'

  @get '/push_channels/:pushChannelId/push_devices/:pushDeviceId/push_messages', makeGetChildrenHandler('push_device', 'push_message')
  @get '/push_channels/:pushChannelId/push_devices/:pushDeviceId/push_messages/:id'

  @get '/store_collections'
  @post '/store_collections', makePostHandler 'store_collection'
  @get '/store_collections/:id'
  @put '/store_collections/:id', makePutHandler 'store_collection'
  @del '/store_collections/:id'

  @get '/store_collections/:storeCollectionId/store_objects', makeGetChildrenHandler('store_collection', 'store_object')
  @post '/store_collections/:storeCollectionId/store_objects', makePostChildHandler('store_collection', 'store_object')
  @get '/store_collections/:storeCollectionId/store_objects/:id'
  @put '/store_collections/:storeCollectionId/store_objects/:id', makePutHandler 'store_object'
  @del '/store_collections/:storeCollectionId/store_objects/:id'

  @get '/account', (schema, request) -> schema.account.all()[0]
  @put '/account', (schema, request) ->
    body = JSON.parse request.requestBody
    payload = body.account
    if body.account?.name is 'error'
      response = new Response 422, {},
        errors:
          name: ['This field is in error']
    else
      response = schema.account.all()[0].update payload
    response
  @delete '/account', ->
    new Response 200

  @get '/keys'
  @post '/keys', makePostHandler 'key'
  @del '/keys/:id'

  @get '/users'
  @post '/users', makePostHandler 'user'
  @get '/users/:id'
  @put '/users/:id', makePutHandler 'user'
  @del '/users/:id'

  @get '/apis'
  @post '/apis', makePostHandler 'api'
  @get '/apis/:id'
  @put '/apis/:id', makePutHandler 'api'
  @del '/apis/:id'

  @get '/apis/:apiId/environments', makeGetChildrenHandler('api', 'environment')
  @post '/apis/:apiId/environments', makePostChildHandler('api', 'environment')
  @get '/apis/:apiId/environments/:id'
  @put '/apis/:apiId/environments/:id', makePutHandler 'environment'
  @del '/apis/:apiId/environments/:id'

  @get '/environments'

  @get '/apis/:apiId/libraries', makeGetChildrenHandler('api', 'library')
  @post '/apis/:apiId/libraries', makePostChildHandler('api', 'library')
  @get '/apis/:apiId/libraries/:id'
  @put '/apis/:apiId/libraries/:id', makePutHandler 'library'
  @del '/apis/:apiId/libraries/:id'

  @get '/apis/:apiId/hosts', makeGetChildrenHandler('api', 'host')
  @post '/apis/:apiId/hosts', makePostChildHandler('api', 'host')
  @get '/apis/:apiId/hosts/:id'
  @put '/apis/:apiId/hosts/:id', makePutHandler 'host'
  @del '/apis/:apiId/hosts/:id'

  @get '/apis/:apiId/endpoint_groups', makeGetChildrenHandler('api', 'endpoint_group')
  @post '/apis/:apiId/endpoint_groups', makePostChildHandler('api', 'endpoint_group')
  @get '/apis/:apiId/endpoint_groups/:id'
  @put '/apis/:apiId/endpoint_groups/:id', makePutHandler 'endpoint_group'
  @del '/apis/:apiId/endpoint_groups/:id'

  @get '/endpoint_groups'

  @get '/apis/:apiId/remote_endpoints', makeGetChildrenHandler('api', 'remote_endpoint')
  @post '/apis/:apiId/remote_endpoints', makePostChildHandler('api', 'remote_endpoint')
  @get '/apis/:apiId/remote_endpoints/:id'
  @put '/apis/:apiId/remote_endpoints/:id', makePutHandler 'remote_endpoint'
  @del '/apis/:apiId/remote_endpoints/:id'

  @get '/remote_endpoints'

  @get '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads', makeGetChildrenHandler('remote_endpoint_environment_datum', 'scratch_pad')
  @post '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads', makePostChildHandler('remote_endpoint_environment_datum', 'scratch_pad')
  @get '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads/:id'
  @put '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads/:id', makePutHandler 'scratch_pad'
  @del '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads/:id'
  @get '/apis/:apiId/remote_endpoints/:remoteEndpointId/environment_data/:remoteEndpointEnvironmentDatumId/scratch_pads/:id/execute', ->
    time: 100
    request: '{"a": "request"}'
    response: '{"a": "response"}'

  @get '/apis/:apiId/shared_components', makeGetChildrenHandler('api', 'shared_component')
  @post '/apis/:apiId/shared_components', makePostChildHandler('api', 'shared_component')
  @get '/apis/:apiId/shared_components/:id'
  @put '/apis/:apiId/shared_components/:id', makePutHandler 'shared_component'
  @del '/apis/:apiId/shared_components/:id'

  @get '/apis/:apiId/proxy_endpoints', (schema, request) ->
    records = getChildren schema, request, 'api', 'proxy_endpoint'
    simpleRecords = records.map (record) ->
      # remove relationship fields to simulate index payload of actual server
      attrs = Ember.copy record.attrs
      delete attrs.components
      delete attrs.channels
      delete attrs.tests
      delete attrs.routes
      attrs
    proxy_endpoints: simpleRecords
  @post '/apis/:apiId/proxy_endpoints', makePostChildHandler('api', 'proxy_endpoint')
  @get '/apis/:apiId/proxy_endpoints/:id'
  @put '/apis/:apiId/proxy_endpoints/:id', makePutHandler 'proxy_endpoint'
  @del '/apis/:apiId/proxy_endpoints/:id'
  @get '/apis/:apiId/proxy_endpoints/:proxy_endpoint_id/tests/:id/test', (->
    results: [
      {
        method: 'get',
        status: '200',
        headers: [
          {name: 'Date', value: 'Tue, 04 Aug 2015 19:58:11 GMT'},
          {name: 'Content-Length', value: '539'},
          {name: 'Content-Type', value: 'application/json'},
          {name: 'X-Gateway-Requestid', value: 'ed32998f-f857-4335-9f0f-288010ddb282'}
        ],
        body: '{"get-test": "this is a get test"}',
        log: "this is a log message for a get request #{Math.random()}",
        time: 8
      }
    ]
  ), {timing: 2000}

  @get '/apis/:apiId/proxy_endpoints/:proxyEndpointId/channels', makeGetChildrenHandler('proxy_endpoint', 'proxy_endpoint_channel')
  @post '/apis/:apiId/proxy_endpoints/:proxyEndpointId/channels', makePostChildHandler('proxy_endpoint', 'proxy_endpoint_channel', null, 'channel')
  @get '/apis/:apiId/proxy_endpoints/:proxyEndpointId/channels/:id', (schema, request) ->
    channel: schema.db.proxyEndpointChannels.find request.params.id
  @put '/apis/:apiId/proxy_endpoints/:proxyEndpointId/channels/:id', makePutHandler('proxy_endpoint_channel', null, 'channel')
  @del '/apis/:apiId/proxy_endpoints/:proxyEndpointId/channels/:id', (schema, request) ->
    id = request.params.id
    schema.db.proxyEndpointChannels.remove id

  @get '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas', makeGetChildrenHandler('proxy_endpoint', 'proxy_endpoint_schema')
  @post '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas', makePostChildHandler('proxy_endpoint', 'proxy_endpoint_schema')
  @get '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas/:id', (schema, request) ->
    proxy_endpoint_schema: schema.db.proxyEndpointSchemas.find request.params.id
  @put '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas/:id', makePutHandler 'proxy_endpoint_schema'
  @del '/apis/:apiId/proxy_endpoints/:proxyEndpointId/schemas/:id', (schema, request) ->
    id = request.params.id
    schema.db.proxyEndpointSchemas.remove id

  @get '/apis/:apiId/jobs', makeGetChildrenHandler('api', 'job')
  @post '/apis/:apiId/jobs', makePostChildHandler('api', 'job')
  @get '/apis/:apiId/jobs/:id'
  @put '/apis/:apiId/jobs/:id', makePutHandler 'job'
  @del '/apis/:apiId/jobs/:id'

  @get '/apis/:apiId/jobs/:jobId/tests', makeGetChildrenHandler('job', 'job_test')
  @post '/apis/:apiId/jobs/:jobId/tests', makePostChildHandler('job', 'job_test')
  @get '/apis/:apiId/jobs/:jobId/tests/:id', (schema, request) ->
    job_test: schema.db.jobTests.find request.params.id
  @put '/apis/:apiId/jobs/:jobId/tests/:id', makePutHandler 'job_test'
  @del '/apis/:apiId/jobs/:jobId/tests/:id', (schema, request) ->
    id = request.params.id
    schema.db.jobTests.remove id
  @get '/apis/:apiId/jobs/:job_id/tests/:id/test', (->
    result: {
      log: "this is a log message for a get request #{Math.random()}",
      time: 8
    }
  ), {timing: 2000}

  @get '/jobs'

  @get '/apis/:apiId/custom_functions', makeGetChildrenHandler('api', 'custom_function')
  @post '/apis/:apiId/custom_functions', makePostChildHandler('api', 'custom_function')
  @get '/apis/:apiId/custom_functions/:id'
  @put '/apis/:apiId/custom_functions/:id', makePutHandler 'custom_function'
  @del '/apis/:apiId/custom_functions/:id'

  @get '/apis/:apiId/custom_functions/:customFunctionId/tests', makeGetChildrenHandler('custom_function', 'custom_function_test')
  @post '/apis/:apiId/custom_functions/:customFunctionId/tests', makePostChildHandler('custom_function', 'custom_function_test', null, 'test')
  @get '/apis/:apiId/custom_functions/:customFunctionId/tests/:id', (schema, request) ->
    test: schema.db.customFunctionTests.find request.params.id
  @put '/apis/:apiId/custom_functions/:customFunctionId/tests/:id', makePutHandler('custom_function_test', null, 'test')
  @del '/apis/:apiId/custom_functions/:customFunctionId/tests/:id', (schema, request) ->
    id = request.params.id
    schema.db.customFunctionTests.remove id
  @get '/apis/:apiId/custom_functions/:customFunctionId/tests/:id/test', (->
    result: {
      output: '{"test": "message"}'
      log: "this is a log message for a get request #{Math.random()}",
      time: 8
    }
  ), {timing: 2000}

  @get '/apis/:apiId/custom_functions/:customFunctionId/files', makeGetChildrenHandler('custom_function', 'custom_function_file')
  @post '/apis/:apiId/custom_functions/:customFunctionId/files', makePostChildHandler('custom_function', 'custom_function_file', null, 'file')
  @get '/apis/:apiId/custom_functions/:customFunctionId/files/:id', (schema, request) ->
    test: schema.db.customFunctionFiles.find request.params.id
  @put '/apis/:apiId/custom_functions/:customFunctionId/files/:id', makePutHandler('custom_function_file', null, 'file')
  @del '/apis/:apiId/custom_functions/:customFunctionId/files/:id', (schema, request) ->
    id = request.params.id
    schema.db.customFunctionFiles.remove id

  @get '/timers'
  @post '/timers', makePostHandler 'timer'
  @get '/timers/:id'
  @put '/timers/:id', makePutHandler 'timer'
  @del '/timers/:id'

`export default config`
