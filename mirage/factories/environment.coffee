`import { Factory, faker } from 'ember-cli-mirage'`

EnvironmentFactory = Factory.extend
  name: -> faker.hacker.noun().capitalize()
  description: -> faker.lorem.sentence()
  data:
    foo: 'bar'
    baz: 'baf'
  session_name: -> faker.hacker.phrase().underscore()
  session_auth_key: -> faker.internet.password()
  session_encryption_key: -> faker.internet.password()
  session_auth_key_rotate: -> faker.internet.password()
  session_encryption_key_rotate: -> faker.internet.password()

`export default EnvironmentFactory`
