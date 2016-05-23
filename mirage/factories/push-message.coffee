`import { Factory, faker } from 'ember-cli-mirage'`

PushMessageFactory = Factory.extend
  stamp: -> Date.now() / 1000 - faker.random.number()
  data: ->
    aps:
      alert:
        body: "A test Message"
      'url-args': []

`export default PushMessageFactory`
