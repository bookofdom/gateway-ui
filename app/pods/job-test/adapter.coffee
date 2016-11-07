`import JobRelatedAdapter from 'gateway/pods/job-related/adapter'`

JobTestAdapter = JobRelatedAdapter.extend
  buildTestUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'job-test', null, snapshot}/test"

  ###
  model:  environment instance
  ###
  executeTest: (model) ->
    url = @buildTestUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        result = response?.result
        if result
          resolve result
        else
          reject response

`export default JobTestAdapter`
