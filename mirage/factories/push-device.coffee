`import { Factory, faker } from 'ember-cli-mirage'`
`import { nameCycle } from 'gateway/mirage/helpers/push-device'`
`import { platformCycle } from 'gateway/mirage/helpers/remote-endpoint-data'`

PushDeviceFactory = Factory.extend
  name: (i) -> nameCycle i
  type: (i) -> platformCycle i
  token: -> faker.random.uuid()
  expires: -> Date.now() / 1000 + faker.random.number()

`export default PushDeviceFactory`
