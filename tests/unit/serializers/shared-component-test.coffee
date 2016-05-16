`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'shared-component', 'Unit | Serializer | shared component',
  needs: [
    'serializer:api'
    'serializer:shared-component'
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
        ,
          type: 'js'
          conditional: '...'
          data: '...'
          conditional_positive: false
          description: 'Consequatur quo officiis libero.'
          name: 'Robust Component 2'
          id: 2
          api_id: 1
        ,
          type: 'js'
          conditional: '...'
          data: '...'
          conditional_positive: false
          description: 'Consequatur quo officiis libero.'
          name: 'Robust Component 3'
          id: 3
          api_id: 1
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('api').then (apis) ->
    api = apis.get('firstObject')
    api.get('shared_components').then (shared_components) ->
      assert.equal shared_components.get('length'), 3
