`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway-ui/pods/api-related/serializer'`

EndpointGroupSerializer = ApiRelatedSerializer.extend
  attrs:
    api:
      serialize: false

`export default EndpointGroupSerializer`
