`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ProxyEndpointSchemaSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  normalize: (type, hash, property) ->
    try
      hash.request_schema = vkbeautify.json hash.request_schema
    try
      hash.response_schema = vkbeautify.json hash.response_schema
    @_super arguments...

`export default ProxyEndpointSchemaSerializer`
