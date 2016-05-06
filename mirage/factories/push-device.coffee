`import { Factory, faker } from 'ember-cli-mirage'`

PushDeviceFactory = Factory.extend
  name: -> faker.commerce.productName()
  token: -> faker.random.uuid()
  expires: -> Date.now() / 1000 + faker.random.number()

`export default PushDeviceFactory`
