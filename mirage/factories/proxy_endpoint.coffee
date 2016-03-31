`import { Factory, faker } from 'ember-cli-mirage'`

ProxyEndpointFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  description: -> faker.lorem.sentence()
  active: -> faker.random.boolean()
  cors_enabled: -> faker.random.boolean()
  environment_id: -> (faker.random.number() % 3) + 1
  endpoint_group_id: -> (faker.random.number() % 5) + 1
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

`export default ProxyEndpointFactory`
