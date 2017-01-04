`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

JobRelatedAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    @_super type.replace(/^job-/, '')
  buildURL: (type, id, snapshot) ->
    if snapshot
      # snapshots
      jobSnapshot = snapshot.belongsTo 'job'
      # adapters
      jobAdapter = Ember.getOwner(@).lookup 'adapter:job'
      # IDs
      snapshotId = snapshot.id
      jobId = jobSnapshot.id
      # URLs
      jobModelName = jobSnapshot.modelName
      jobUrl = jobAdapter.buildURL jobModelName, jobId, jobSnapshot
      if snapshotId
        url = "#{jobUrl}/#{@pathForType(type)}/#{snapshotId}"
      else
        url = "#{jobUrl}/#{@pathForType(type)}"
      @cleanURL url

`export default JobRelatedAdapter`
