`import { Factory, faker } from 'ember-cli-mirage'`

InfoFactory = Factory.extend
  id: -> 'app'
  version: -> faker.random.number()

`export default InfoFactory`
