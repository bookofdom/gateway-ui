`import { Factory, faker } from 'ember-cli-mirage'`

PushChannelMessageFactory = Factory.extend
  stamp: -> (Date.now() / 1000) - faker.random.number()
  data: ->
    apple:
      aps:
        body: 'Test Message'
        badge: faker.random.number()

`export default PushChannelMessageFactory`
