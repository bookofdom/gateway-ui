`import { Factory, faker } from 'ember-cli-mirage'`

EnvironmentFactory = Factory.extend
  name: (i) -> faker.list.cycle('development', 'staging', 'production')(i).capitalize()
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
