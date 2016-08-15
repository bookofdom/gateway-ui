`import { Factory, faker } from 'ember-cli-mirage'`

AccountFactory = Factory.extend
  name: -> faker.lorem.words()[0].capitalize()
  card_invalid: -> faker.random.boolean()

`export default AccountFactory`
