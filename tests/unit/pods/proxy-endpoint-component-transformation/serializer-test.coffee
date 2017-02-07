`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'proxy-endpoint-component-transformation', 'Unit | Serializer | proxy endpoint component transformation',

  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:proxy-endpoint'
    'serializer:proxy-endpoint-component'
    'serializer:proxy-endpoint-component-call'
    'serializer:proxy-endpoint-component-transformation'
    'model:api'
    'model:custom-function'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:library'
    'model:proxy-endpoint'
    'model:proxy-endpoint-channel'
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-component-call'
    'model:proxy-endpoint-component-transformation'
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
          environment_data: null
        ]
      ]
      @get '/apis/1/proxy_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify proxy_endpoints: [
          tests: []
          routes: []
          components: [
            before: [
              id: 1,
              type: 'js',
              data: 'before multi'
            ,
              id: 2,
              type: 'js',
              data: 'before multi'
            ]
            after: [
              id: 1,
              type: 'js',
              data: 'after multi'
            ,
              id: 2,
              type: 'js',
              data: 'after multi'
            ]
            calls: []
            type: 'multi'
            conditional: 'var foo ...'
            data: '...'
            conditional_positive: true
            description: 'Omnis id voluptatum tempora blanditiis dolorem quas atque quia ducimus.'
            name: 'Cross-platform Component'
            proxy_endpoint_component_id: 1
            id: 1
            proxyEndpointId: 1
            proxy_endpoint_component_reference_id: '14'
          ]
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

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('proxy_endpoints').then (proxy_endpoints) ->
      proxy_endpoint = proxy_endpoints.get('firstObject')
      proxy_endpoint_components = proxy_endpoint.get('components')
      proxy_endpoint_component = proxy_endpoint_components.get('firstObject')
      proxy_endpoint_component_transformations_before = proxy_endpoint_component.get('before')
      assert.equal proxy_endpoint_component_transformations_before.get('length'), 2
      proxy_endpoint_component_transformations_after = proxy_endpoint_component.get('after')
      assert.equal proxy_endpoint_component_transformations_after.get('length'), 2
