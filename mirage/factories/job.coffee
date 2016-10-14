`import { Factory, faker } from 'ember-cli-mirage'`

environmentsPerApi = 3
endpointGroupsPerApi = 5

JobFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  description: -> faker.lorem.sentence()
  environment_id: ->
    ((+@apiId - 1) * environmentsPerApi) + (faker.random.number() % 3) + 1
  endpoint_group_id: ->
    ((+@apiId - 1) * endpointGroupsPerApi) + (faker.random.number() % 5) + 1
  components: null

`export default JobFactory`
