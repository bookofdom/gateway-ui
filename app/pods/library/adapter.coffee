`import ApiRelatedAdapter from 'gateway/pods/api-related/adapter'`

LibraryAdapter = ApiRelatedAdapter.extend
  errorMappings:
    data: 'body'

`export default LibraryAdapter`
