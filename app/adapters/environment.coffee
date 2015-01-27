`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

EnvironmentAdapter = ApplicationAdapter.extend
  buildURL: (type, id, record) ->
    url = @_super.apply @, arguments
    basePath = config.api.basePath
    url = url.split "/#{basePath}/"
    apiId = record?.get 'api.id'
    # inserts the environment API's path in front of the environment path
    # environment URLs are nested under API
    if apiId
      url.insertAt 1, basePath
      url.insertAt 2, @pathForType('api')
      url.insertAt 3, apiId
    url.join('/')

`export default EnvironmentAdapter`
