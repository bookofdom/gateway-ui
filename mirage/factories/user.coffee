`import { Factory, faker } from 'ember-cli-mirage'`

ApiFactory = Factory.extend
  name: -> "#{faker.name.firstName()} #{faker.name.lastName()}"
  email: -> faker.internet.email().toLowerCase()
  admin: -> faker.random.boolean()
  confirmed: -> faker.random.boolean()

`export default ApiFactory`
