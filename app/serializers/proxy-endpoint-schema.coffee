`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ProxyEndpointSchemaSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    request_json_schema:
      embedded: 'always'
    response_json_schema:
      embedded: 'always'

  normalize: (type, hash, property) ->
    # beautify JSON for code editors
    try
      hash.request_schema = vkbeautify.json hash.request_schema
    try
      hash.response_schema = vkbeautify.json hash.response_schema
    # use JSON for embedded schema models
    try
      hash.request_json_schema = JSON.parse hash.request_schema
    try
      hash.response_json_schema = JSON.parse hash.response_schema
    @_super arguments...

  serialize: (snapshot) ->
    serialized = @_super arguments...
    # Serialize JSON schema nodes into schema fields if they are flagged.
    if serialized.serialize_request_json_schema
      try
        serialized.request_schema = JSON.stringify snapshot.belongsTo('request_json_schema').serialize()
    if serialized.serialize_response_json_schema
      try
        serialized.response_schema = JSON.stringify snapshot.belongsTo('response_json_schema').serialize()
    delete serialized.serialize_request_json_schema
    delete serialized.serialize_response_json_schema
    delete serialized.request_json_schema
    delete serialized.response_json_schema
    serialized

`export default ProxyEndpointSchemaSerializer`
