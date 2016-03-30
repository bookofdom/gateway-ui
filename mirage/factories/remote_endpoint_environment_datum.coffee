`import { Factory, faker } from 'ember-cli-mirage'`
`import { generateDataForType } from 'gateway/mirage/helpers/remote-endpoint-data'`

RemoteEndpointEnvironmentDatumFactory = Factory.extend
  environment_id: (i) -> faker.list.cycle(1, 2, 3)(i)
  data: (i) -> generateDataForType(@type, i) if @type

`export default RemoteEndpointEnvironmentDatumFactory`
