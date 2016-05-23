`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/serializers/api-related'`

HostSerializer = ApiRelatedSerializer.extend
  attrs:
    api:
      serialize: false

`export default HostSerializer`
