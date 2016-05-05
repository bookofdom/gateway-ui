`import { Factory, faker } from 'ember-cli-mirage'`

StoreCollectionFactory = Factory.extend
  name: -> faker.commerce.productName()

`export default StoreCollectionFactory`
