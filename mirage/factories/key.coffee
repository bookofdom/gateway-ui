`import { Factory, faker } from 'ember-cli-mirage'`

KeyFactory = Factory.extend
  name: -> faker.name.firstName()
  key: -> 'data:text/plain;charset=utf-8;base64,aGV5YQ=='

`export default KeyFactory`
