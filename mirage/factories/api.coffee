`import { Factory, faker } from 'ember-cli-mirage'`

ApiFactory = Factory.extend
  name: -> faker.commerce.productName()
  base_url: -> "http://www.#{faker.internet.domainName()}"
  description: -> faker.lorem.sentence()

`export default ApiFactory`
