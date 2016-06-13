`import { Factory, faker } from 'ember-cli-mirage'`

testId = 1
testPairId = 1

environmentsPerApi = 3
endpointGroupsPerApi = 5

ProxyEndpointFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  description: -> faker.lorem.sentence()
  active: -> faker.random.boolean()
  cors_enabled: -> faker.random.boolean()
  environment_id: ->
    ((+@apiId - 1) * environmentsPerApi) + (faker.random.number() % 3) + 1
  endpoint_group_id: ->
    ((+@apiId - 1) * endpointGroupsPerApi) + (faker.random.number() % 5) + 1
  components: null
  routes: ->
    [
      path: "/#{faker.lorem.words()[0]}/#{faker.lorem.words()[0]}/"
      methods: ["GET"]
    ,
      path: "/#{faker.lorem.words()[0]}/#{faker.lorem.words()[0]}/"
      methods: ["GET", "POST", "PUT", "DELETE"]
    ,
      path: "/#{faker.lorem.words()[0]}/#{faker.lorem.words()[0]}/"
      methods: ["POST", "PUT"]
    ]
  tests: ->
    for i in [1..3]
      id: testId++
      name: "#{faker.lorem.words()[0].capitalize()} Test"
      methods: ["GET", "POST", "PUT", "DELETE"]
      route: "/#{faker.lorem.words()[0]}/#{faker.lorem.words()[0]}.json"
      pairs: [
        id: testPairId++
        type: 'get'
        key: 'key'
        value: 'value'
      ,
        id: testPairId++
        type: 'header'
        key: 'Content-Type'
        value: 'application/json'
      ,
        id: testPairId++
        type: 'path'
        key: 'key'
        value: 'value'
      ]

`export default ProxyEndpointFactory`
