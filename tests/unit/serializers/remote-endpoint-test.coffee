`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'remote-endpoint', 'Unit | Serializer | remote endpoint',
  needs: [
    'serializer:api'
    'serializer:environment'
    'serializer:remote-endpoint'
    'serializer:remote-endpoint-like'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:remote-endpoint-environment-datum'
    'model:remote-endpoint-environment-datum-scratch-pad'
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
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
        ]
      ]
      @get '/apis/1/remote_endpoints', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify remote_endpoints: [
          api_id: 1
          id: 1
          name: 'Alerts - GET'
          codename: 'alerts'
          description: ''
          type: 'http'
          status: null
          status_message: null
          data:
            url: 'http://justapis-mock.herokuapp.com/v1/alerts'
            query: {}
            method: 'GET'
            headers: {}
          environment_data: [
            remote_endpoint_id: 1
            environment_id: 1
            type: 'http'
            data:
              url: 'http://dev.test'
              query: {}
              method: 'GET'
              headers: {}
          ]
        ,
          api_id: 1
          id: 2
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
              Authorization: 'Basic YW55cHJlc2VuY2U6cGFzc3dvcmQ='
          environment_data: null
        ]
      ]

    afterEach: ->
      @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('remote_endpoints').then (remote_endpoints) ->
      assert.equal remote_endpoints.get('length'), 2
