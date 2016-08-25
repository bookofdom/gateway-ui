`import { Factory, faker } from 'ember-cli-mirage'`

AccountFactory = Factory.extend
  name: -> faker.lorem.words()[0].capitalize()

`export default AccountFactory`
