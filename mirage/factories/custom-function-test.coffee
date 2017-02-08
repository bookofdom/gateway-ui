`import { Factory, faker } from 'ember-cli-mirage'`

CustomFunctionTestFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  input: -> '{"message": "hello world"}'

`export default CustomFunctionTestFactory`
