`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway-ui/pods/api-related/serializer'`
`import HttpRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/http'`
`import SoapRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/soap'`
`import SqlserverRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/sqlserver'`
`import PostgresRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/postgres'`
`import MysqlRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/mysql'`
`import MongodbRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/mongodb'`
`import LdapRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/ldap'`
`import ScriptRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/script'`
`import HanaRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/hana'`
`import PushRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/push'`
`import RedisRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/redis'`
`import OracleRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/oracle'`
`import SmtpRemoteEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/smtp'`
`import Db2EndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/db2'`
`import DockerEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/docker'`
`import KeyEndpointSerializer from 'gateway-ui/pods/remote-endpoint/serializers/key'`

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
      embedded: 'always'
    arguments:
      serialize: false
      deserialize: 'records'
    environment_variables:
      serialize: false
      deserialize: 'records'

  # Normalization
  normalize: (type, hash, property) ->
    hash.headers = [] if !hash.headers
    hash.query = [] if !hash.query
    hash.hosts = [] if !hash.hosts
    hash.arguments = [] if !hash.arguments
    hash.environment_data = [] if !hash.environment_data
    hash.environment_variables = [] if !hash.environment_variables
    hash.data ?= {}
    # normalize embedded resources
    @normalizeArguments hash
    @normalizeEnvironmentData hash
    @normalizeScratchPadLinks hash
    Ember.merge hash,
      headers: @objectToArray hash.data.headers
      query: @objectToArray hash.data.query
      hosts: hash.data.config?.hosts or []
      environment_variables: @objectToArray hash.data.environment
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
      when 'oracle' then OracleRemoteEndpointSerializer.normalize hash
      when 'smtp' then SmtpRemoteEndpointSerializer.normalize hash
      when 'db2' then Db2EndpointSerializer.normalize hash
      when 'key' then KeyEndpointSerializer.normalize hash
      when 'docker' then DockerEndpointSerializer.normalize hash
    @_super arguments...
  normalizeArguments: (hash) ->
    if hash.data.arguments
      hash.arguments = (value: value for value in hash.data.arguments)
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
    # serialize attributes
    switch serialized.type
      when 'http'
        HttpRemoteEndpointSerializer.serialize serialized
        Ember.merge serialized.data,
          headers: @serializeHeaders snapshot
          query: @serializeQuery snapshot
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
      when 'oracle' then OracleRemoteEndpointSerializer.serialize serialized
      when 'smtp' then SmtpRemoteEndpointSerializer.serialize serialized
      when 'db2' then Db2EndpointSerializer.serialize serialized
      when 'key' then KeyEndpointSerializer.serialize serialized
      when 'docker'
        DockerEndpointSerializer.serialize serialized
        Ember.merge serialized.data,
          arguments: @serializeArguments snapshot
          environment: @serializeEnvironmentVariables snapshot
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
  serializeArguments: (snapshot) ->
    args = snapshot.hasMany 'arguments'
    if args
      args?.map (arg) -> arg.attributes().value
    else
      []
  serializeEnvironmentVariables: (snapshot) ->
    envVars = {}
    snapshot.hasMany('environment_variables')?.forEach (envVarSnapshot) ->
      attributes = envVarSnapshot.attributes()
      envVars[attributes.name] = attributes.value
    envVars

`export default RemoteEndpointLikeSerializer`
