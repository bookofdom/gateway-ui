`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'proxy-endpoint-test', 'Unit | Serializer | proxy endpoint test',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:proxy-endpoint'
    'serializer:proxy-endpoint-test'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:library'
    'model:proxy-endpoint'
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-route'
    'model:proxy-endpoint-schema'
    'model:proxy-endpoint-test'
    'model:proxy-endpoint-test-argument'
    'model:proxy-endpoint-test-header'
    'model:proxy-endpoint-test-query-parameter'
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
      @get '/apis/1/proxy_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify proxy_endpoints: [
          tests: [
            id: 1
            name: 'Ducimus Test'
            methods: ['GET', 'POST', 'PUT', 'DELETE']
            route: '/laudantium/eius.json'
            pairs: []
          ,
            id: 2,
            name: 'Voluptatem Test'
            methods: ['GET', 'POST', 'PUT', 'DELETE']
            route: '/unde/repudiandae.json'
            pairs: []
          ]
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

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('proxy_endpoints').then (proxy_endpoints) ->
      proxy_endpoint = proxy_endpoints.get('firstObject')
      proxy_endpoint_tests = proxy_endpoint.get('tests')
      assert.equal proxy_endpoint_tests.get('length'), 2
