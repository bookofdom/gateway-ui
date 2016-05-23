`import { Factory, faker } from 'ember-cli-mirage'`
`import { nameCycle } from 'gateway/mirage/helpers/push-channel'`

PushChannelFactory = Factory.extend
  name: (i) -> nameCycle i
  expires: -> Date.now() / 1000 + faker.random.number()
  api_id: -> (faker.random.number() % 3) + 1
  remote_endpoint_id: -> (faker.random.number() % 3) + 1

`export default PushChannelFactory`
