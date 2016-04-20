`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'shared-component-call', 'Unit | Serializer | shared component call',
  needs: [
    'serializer:api'
    'serializer:shared-component'
    'serializer:shared-component-call'
    'serializer:shared-component-transformation'
    'model:api'
    'model:environment-variable'
    'model:endpoint-group'
    'model:environment'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:shared-component'
    'model:shared-component-call'
    'model:shared-component-transformation'
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
      @get '/apis/1/shared_components', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify shared_components: [
          type: 'js'
          conditional: '...'
          data: '...'
          conditional_positive: false
          description: 'Consequatur quo officiis libero.'
          name: 'Robust Component 1'
          id: 1
          api_id: 1
          calls: [
            remote_endpoint_id: 1
            endpoint_name_override: 'multiOverride 1'
            conditional: '...'
            conditional_positive: false
            before: [
              id: 1
              type: 'js'
              data: 'before multi call'
            ]
            after: [
              id: 2
              type: 'js'
              data: 'after multi call'
            ]
          ,
            remote_endpoint_id: 1
            endpoint_name_override: 'multiOverride 2'
            conditional: '...'
            conditional_positive: false
            before: [
              id: 1
              type: 'js'
              data: 'before multi call'
            ]
            after: [
              id: 2
              type: 'js'
              data: 'after multi call'
            ]
          ,
            remote_endpoint_id: 1
            endpoint_name_override: 'multiOverride 3'
            conditional: '...'
            conditional_positive: false
            before: [
              id: 1
              type: 'js'
              data: 'before multi call'
            ]
            after: [
              id: 2
              type: 'js'
              data: 'after multi call'
            ]
          ]
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('shared_components').then (shared_components) ->
      shared_component = shared_components.get('firstObject')
      shared_component_calls = shared_component.get('calls')
      assert.equal shared_component_calls.get('length'), 3
