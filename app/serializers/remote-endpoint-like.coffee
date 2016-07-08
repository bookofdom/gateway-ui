`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/serializers/api-related'`
`import HttpRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/http'`
`import SoapRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/soap'`
`import SqlserverRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/sqlserver'`
`import PostgresRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/postgres'`
`import MysqlRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/mysql'`
`import MongodbRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/mongodb'`
`import LdapRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/ldap'`
`import ScriptRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/script'`
`import HanaRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/hana'`
`import PushRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/push'`
`import RedisRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/redis'`
`import SmtpRemoteEndpointSerializer from 'gateway/serializers/remote-endpoint/smtp'`

RemoteEndpointLikeSerializer = ApiRelatedSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    hosts:
      embedded: 'always'
    push_platforms:
      serialize: false
      deserialize: 'records'

  # Normalization
  normalize: (type, hash, property) ->
    hash.headers = [] if !hash.headers
    hash.query = [] if !hash.query
    hash.hosts = [] if !hash.hosts
    hash.environment_data = [] if !hash.environment_data
    hash.data ?= {}
    # normalize embedded resources
    @normalizeEnvironmentData hash
    @normalizeScratchPadLinks hash
    Ember.merge hash,
      headers: @objectToArray hash.data.headers
      query: @objectToArray hash.data.query
      hosts: hash.data.config?.hosts or []
      push_platforms: hash.data.push_platforms or []
    # normalize attributes
    switch hash.type
      when 'http' then HttpRemoteEndpointSerializer.normalize hash
      when 'soap' then SoapRemoteEndpointSerializer.normalize hash
      when 'sqlserver' then SqlserverRemoteEndpointSerializer.normalize hash
      when 'postgres' then PostgresRemoteEndpointSerializer.normalize hash
      when 'mysql' then MysqlRemoteEndpointSerializer.normalize hash
      when 'mongodb' then MongodbRemoteEndpointSerializer.normalize hash
      when 'ldap' then LdapRemoteEndpointSerializer.normalize hash
      when 'script' then ScriptRemoteEndpointSerializer.normalize hash
      when 'hana' then HanaRemoteEndpointSerializer.normalize hash
      when 'push' then PushRemoteEndpointSerializer.normalize hash
      when 'redis' then RedisRemoteEndpointSerializer.normalize hash
      when 'smtp' then SmtpRemoteEndpointSerializer.normalize hash
    @_super arguments...
  normalizeEnvironmentData: (hash) ->
    hash.environment_data ?= []
    datum.type = hash.type for datum in hash.environment_data
  normalizeScratchPadLinks: (hash) ->
    hash.environment_data.forEach (datum) ->
      datum.links =
        scratch_pads: "/apis/#{hash.api_id}/remote_endpoints/#{hash.id}/environment_data/#{datum.id}/scratch_pads"
  objectToArray: (obj={}) ->
    for key, value of obj
      name: key
      value: value

  # Serialization
  serialize: (snapshot) ->
    serialized = @_super arguments...
    # serialize embedded records
    serialized.data ?= {}
    Ember.merge serialized.data,
      headers: @serializeHeaders snapshot
      query: @serializeQuery snapshot
      push_platforms: @serializePushPlatforms snapshot
    # serialize attributes
    switch serialized.type
      when 'http' then HttpRemoteEndpointSerializer.serialize serialized
      when 'soap' then SoapRemoteEndpointSerializer.serialize serialized
      when 'sqlserver'
        SqlserverRemoteEndpointSerializer.serialize serialized
      when 'postgres' then PostgresRemoteEndpointSerializer.serialize serialized
      when 'mysql' then MysqlRemoteEndpointSerializer.serialize serialized
      when 'mongodb' then MongodbRemoteEndpointSerializer.serialize serialized
      when 'ldap' then LdapRemoteEndpointSerializer.serialize serialized
      when 'script' then ScriptRemoteEndpointSerializer.serialize serialized
      when 'hana' then HanaRemoteEndpointSerializer.serialize serialized
      when 'push' then PushRemoteEndpointSerializer.serialize serialized
      when 'redis' then RedisRemoteEndpointSerializer.serialize serialized
      when 'smtp' then SmtpRemoteEndpointSerializer.serialize serialized
    serialized
  serializeHeaders: (snapshot) ->
    headers = {}
    snapshot.hasMany('headers')?.forEach (headerSnapshot) ->
      attributes = headerSnapshot.attributes()
      headers[attributes.name] = attributes.value
    headers
  serializeQuery: (snapshot) ->
    query = {}
    snapshot.hasMany('query')?.forEach (querySnapshot) ->
      attributes = querySnapshot.attributes()
      query[attributes.name] = attributes.value
    query
  serializePushPlatforms: (snapshot) ->
    push_platforms = []
    snapshot.hasMany('push_platforms')?.forEach (pushPlatform) ->
      push_platforms.push pushPlatform.attributes()
    push_platforms

`export default RemoteEndpointLikeSerializer`
