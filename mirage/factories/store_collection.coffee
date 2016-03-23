`import { Factory, faker } from 'ember-cli-mirage'`

ApiFactory = Factory.extend
  name: -> faker.commerce.productName()

`export default ApiFactory`
