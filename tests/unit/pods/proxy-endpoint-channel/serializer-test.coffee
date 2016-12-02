`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'proxy-endpoint-channel', 'Unit | Serializer | proxy endpoint channel',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:proxy-endpoint'
    'serializer:proxy-endpoint-channel'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:library'
    'model:proxy-endpoint'
    'model:proxy-endpoint-channel'
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-route'
    'model:proxy-endpoint-schema'
    'model:proxy-endpoint-test'
    'model:remote-endpoint'
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
      @get '/apis/1/endpoint_groups', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify endpoint_groups: [
          api_id: 1
          id: 1
          name: 'Event Calls'
        ]
      ]
      @get '/apis/1/environments', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify environments: [
          api_id: 1
          id: 1
          name: 'One'
        ]
      ]
      @get '/apis/1/remote_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify remote_endpoints: [
          # push
          api_id: '1'
          id: 1
          name: "Test"
          codename: "test"
          description: ""
          type: 'push'
          status: null
          status_message: null
          data:
            headers: {}
            query: {}
            push_platforms: [
              name: "test"
              codename: "test"
              type: "osx"
              certificate: "data:application/x-pkcs12;base64,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"
              development: false
            ,
              name: 'test-gcm'
              codename: 'test-gcm'
              platform_type: 'gcm'
              development: false
              api_key: 'AIzaSyCPc6PN7PkKT7BGj-b60XAmEpp6f9N1oNY'
            ,
              name: 'test-mqtt'
              codename: 'test-mqtt'
              platform_type: 'mqtt'
              password: 'abc123'
              connect_timeout: 2
              ack_timeout: 20
              timeout_retries: 3
            ]
            publish_endpoint: true
            subscribe_endpoint: true
            unsubscribe_endpoint: true
          environment_data: [
            id: 8
            environment_id: 1
            type: "push"
            data:
              headers: {}
              query: {}
              push_platforms: [
                name: "gcm"
                codename: "gcm"
                type: "gcm"
                development: false
                api_key: "AIzaSyCPc6PN7PkKT7BGj-b60XAmEpp6f9N1oNY"
              ]
              publish_endpoint: false
          ]
        ]
      ]
      @get '/apis/1/proxy_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify proxy_endpoints: [
          tests: []
          routes: []
          components: []
          endpoint_group_id: 1
          environment_id: 1
          cors_enabled: false
          active: false
          description: 'Neque adipisci est.'
          name: 'Qui'
          id: 1
          api_id: 1
        ]
      ]
      @get '/apis/1/proxy_endpoints/1/channels', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify channels: [
          name: 'channel-1'
          id: 1
          proxy_endpoint_id: 1
          remote_endpoint_id: 1
        ,
          name: 'channel-2'
          id: 2
          proxy_endpoint_id: 1
          remote_endpoint_id: 1
        ,
          name: 'channel-3'
          id: 3
          proxy_endpoint_id: 1
          remote_endpoint_id: 1
        ]
      ]


  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('proxy_endpoints').then (proxy_endpoints) ->
      proxy_endpoint = proxy_endpoints.get('firstObject')
      proxy_endpoint.get('channels').then (channels) ->
        assert.equal channels.get('length'), 3
