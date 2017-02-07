`import { Factory, faker } from 'ember-cli-mirage'`

CustomFunctionFileFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()}"
  body: -> 'a = 1;'

`export default CustomFunctionFileFactory`
