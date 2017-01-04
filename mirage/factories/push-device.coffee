`import { Factory, faker } from 'ember-cli-mirage'`
`import { platformCycle } from 'gateway-ui/mirage/helpers/remote-endpoint-data'`

PushDeviceFactory = Factory.extend
  name: (i) -> "push-device-#{i}"
  type: (i) ->
    pushPlatformType = platformCycle i
    "codename-for-#{pushPlatformType}-platform"
  token: -> faker.random.uuid()
  expires: -> Date.now() / 1000 + faker.random.number()
  qos: -> faker.random.number() % 3

`export default PushDeviceFactory`
