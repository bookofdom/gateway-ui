`import { Factory, faker } from 'ember-cli-mirage'`
`import { generateDataForType } from 'gateway-ui/mirage/helpers/remote-endpoint-data'`

environmentsPerApi = 3

RemoteEndpointEnvironmentDatumFactory = Factory.extend
  environment_id: (i) ->
    ((+@apiId - 1) * environmentsPerApi) + (faker.random.number() % 3) + 1
  data: (i) -> generateDataForType(@type, i) if @type

`export default RemoteEndpointEnvironmentDatumFactory`
