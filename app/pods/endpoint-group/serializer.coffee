`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/serializers/api-related'`

EndpointGroupSerializer = ApiRelatedSerializer.extend
  attrs:
    api:
      serialize: false

`export default EndpointGroupSerializer`
