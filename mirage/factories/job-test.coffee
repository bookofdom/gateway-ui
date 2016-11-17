`import { Factory, faker } from 'ember-cli-mirage'`

JobTestFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()} Test"
  parameters: -> {}

`export default JobTestFactory`
