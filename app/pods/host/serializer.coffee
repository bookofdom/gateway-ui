`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway-ui/pods/api-related/serializer'`

HostSerializer = ApiRelatedSerializer.extend
  attrs:
    api:
      serialize: false

`export default HostSerializer`
