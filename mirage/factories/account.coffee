`import { Factory, faker } from 'ember-cli-mirage'`

plans = 'cloud-free cloud-hosted'.split ' '
planCycle = faker.list.random plans...

AccountFactory = Factory.extend
  plan: -> planCycle

`export default AccountFactory`
