`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'timer', 'Unit | Serializer | timer',
  needs: [
    'serializer:api'
    'serializer:endpoint-group'
    'serializer:environment'
    'serializer:job'
    'serializer:timer'
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:environment-variable'
    'model:host'
    'model:job'
    'model:job-component'
    'model:library'
    'model:proxy-endpoint'
    'model:remote-endpoint'
    'model:shared-component'
    'model:timer'
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
      @get '/apis/1/jobs', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify jobs: [
          api_id: 1
          endpoint_group_id: 1
          environment_id: 1
          id: 1
          name: 'hello world'
        ]
      ]
      @get '/timers', -> [
        200
        {'Content-Type': 'application/json'}
        JSON.stringify timers: [
          api_id: 1
          job_id: 1
          id: 1
          name: 'One'
          once: false
          time_zone: 0
          minute: '*'
          hour: '*'
          day_of_month: '*'
          month: '*'
          day_of_week: '*'
          next: 123
          attributes: {}
        ]
      ]

  afterEach: ->
    @server.shutdown()

test 'it normalizes records', (assert) ->
  @store().findAll('timer').then (timers) ->
    assert.equal timers.get('length'), 1
