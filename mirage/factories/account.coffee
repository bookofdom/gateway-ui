`import { Factory, faker } from 'ember-cli-mirage'`

plans = 'cloud-free cloud-hosted'.split ' '
planCycle = faker.list.random plans...

AccountFactory = Factory.extend
  name: -> faker.lorem.words()[0].capitalize()
  plan: (i) -> planCycle i
  card_invalid: -> faker.random.boolean()

`export default AccountFactory`
