`import { Factory, faker } from 'ember-cli-mirage'`

CustomFunctionFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  description: -> faker.lorem.sentence()
  active: -> faker.random.boolean()
  memory: -> 4 + (faker.random.number() % 128)
  cpu_shares: -> 2 + (faker.random.number() % 8)
  files: null
  tests: null

`export default CustomFunctionFactory`
