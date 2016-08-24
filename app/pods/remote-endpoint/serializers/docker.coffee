DockerEndpointSerializer =
  normalize: (hash) ->
    hash.repository = hash.data.repository
    hash.tag = hash.data.tag
    hash.command = hash.data.command
    hash.arguments = hash.data.arguments?.join?(',')
    hash.environment_variables = hash.data.environment?.join?(',')
    hash.username = hash.data.username
    hash.password = hash.data.password
    hash.registry = hash.data.registry

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      repository: serialized.repository
      tag: serialized.tag
      command: serialized.command
      arguments: serialized.arguments?.split(',')
      environment: serialized.environment_variables?.split(',')
      username: serialized.username
      password: serialized.password
      registry: serialized.registry

`export default DockerEndpointSerializer`
