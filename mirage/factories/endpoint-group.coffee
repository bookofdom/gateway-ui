`import { Factory, faker } from 'ember-cli-mirage'`

EndpointGroupFactory = Factory.extend
  name: -> faker.commerce.productName()
  description: -> faker.lorem.sentence()

`export default EndpointGroupFactory`
