`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'remote-endpoint-environment-datum', 'Unit | Serializer | remote endpoint environment datum',
  needs: [
    'serializer:api'
    'serializer:environment'
    'serializer:remote-endpoint'
    'serializer:remote-endpoint-environment-datum'
    'model:api'
    'model:environment-variable'
    'model:endpoint-group'
    'model:environment'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:remote-endpoint-environment-datum'
    'model:remote-endpoint-environment-datum-scratch-pad'
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
    'model:remote-endpoint-push-platform'
    'model:remote-endpoint-query-parameter'
    'model:shared-component'
  ]
  beforeEach: ->
    @server = new Pretender ->
      @get '/apis', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify apis: [
          id: 1
          name: 'Apples'
        ]
      ]
      @get '/apis/1/environments', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify environments: [
          api_id: 1
          id: 1
          name: 'One'
        ,
          api_id: 1
          id: 2
          name: 'Two'
        ]
      ]
      @get '/apis/1/remote_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify remote_endpoints: [
          # http
          api_id: 1
          id: 1
          name: 'Event - DELETE'
          codename: 'deleteEvent'
          description: ''
          type: 'http'
          status: null
          status_message: null
          data:
            url: ''
            query: {}
            method: 'DELETE'
            headers:
              {}#Authorization: 'Basic YW55cHJlc2VuY2U6cGFzc3dvcmQ='
          environment_data: [
            type: 'soap'
            data:
              serviceName: 'enimexcepturiodit'
              url: 'https://andy.net'
              wssePasswordCredentials:
                username: 'Brayan_Boyer'
                password: 'Y7mUw1L8PtTqHI1'
              headers: {}
                # repellendus: 'online'
              query: {}
                # dolores: 'mobile'
            environment_id: 1
            id: 1
          ,
            type: 'soap'
            data:
              serviceName: 'enimexcepturiodit'
              url: 'https://andy.net'
              wssePasswordCredentials:
                username: 'Brayan_Boyer'
                password: 'Y7mUw1L8PtTqHI1'
              headers: {}
                # repellendus: 'online'
              query: {}
                # dolores: 'mobile'
            environment_id: 1
            id: 2
          ,
            type: 'soap'
            data:
              serviceName: 'enimexcepturiodit'
              url: 'https://andy.net'
              wssePasswordCredentials:
                username: 'Brayan_Boyer'
                password: 'Y7mUw1L8PtTqHI1'
              headers: {}
                # repellendus: 'online'
              query: {}
                # dolores: 'mobile'
            environment_id: 1
            id: 3
          ]
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('environments').then ->
      api.get('remote_endpoints').then (remote_endpoints) ->
        remote_endpoint = remote_endpoints.get('firstObject')
        remote_endpoint_environment_datums = remote_endpoint.get('environment_data')
        assert.equal remote_endpoint_environment_datums.get('length'), 3
