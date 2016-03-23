`import { Factory, faker } from 'ember-cli-mirage'`

StoreObjectFactory = Factory.extend
  data: ->
    name: faker.name.lastName()
    age: faker.random.number()
    obj:
      foo: 'bar'
    arr: [1, 2, 'three', false]

`export default StoreObjectFactory`
