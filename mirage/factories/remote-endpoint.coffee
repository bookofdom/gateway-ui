`import { Factory, faker } from 'ember-cli-mirage'`
`import { typeCycle, statusCycle, generateDataForType } from 'gateway/mirage/helpers/remote-endpoint-data'`

RemoteEndpointFactory = Factory.extend
  name: -> faker.commerce.productName().capitalize()
  codename: -> faker.hacker.noun()
  description: -> faker.lorem.sentence()
  status: (i) -> statusCycle i
  environment_data: null
  type: (i) ->
    typeSlug = typeCycle i
    @data = generateDataForType typeSlug, i
    typeSlug

`export default RemoteEndpointFactory`
