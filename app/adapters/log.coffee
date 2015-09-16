`import ApplicationAdapter from './application'`

LogAdapter = ApplicationAdapter.extend
  enableStreaming: (record) ->
    # no op

`export default LogAdapter`
