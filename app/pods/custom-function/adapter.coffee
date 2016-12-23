`import ApiRelatedAdapter from 'gateway/pods/api-related/adapter'`

CustomFunctionAdapter = ApiRelatedAdapter.extend
  buildBuildUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'custom-function', null, snapshot}/#{model.get('id')}/build"

  ###
  model:  environment instance
  ###
  executeBuild: (model) ->
    url = @buildBuildUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        result = response?.result
        if result
          resolve result
        else
          reject response

`export default CustomFunctionAdapter`
