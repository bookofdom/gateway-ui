`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import config from  'gateway/config/environment'`

CustomFunctionRelatedAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    @_super type.replace(/^custom-function-/, '')
  buildURL: (type, id, snapshot) ->
    if snapshot
      # snapshots
      customFunctionSnapshot = snapshot.belongsTo 'custom_function'
      # adapters
      customFunctionAdapter = Ember.getOwner(@).lookup 'adapter:custom-function'
      # IDs
      snapshotId = snapshot.id
      customFunctionId = customFunctionSnapshot.id
      # URLs
      customFunctionModelName = customFunctionSnapshot.modelName
      customFunctionUrl = customFunctionAdapter.buildURL customFunctionModelName, customFunctionId, customFunctionSnapshot
      if snapshotId
        url = "#{customFunctionUrl}/#{@pathForType(type)}/#{snapshotId}"
      else
        url = "#{customFunctionUrl}/#{@pathForType(type)}"
      @cleanURL url

`export default CustomFunctionRelatedAdapter`
