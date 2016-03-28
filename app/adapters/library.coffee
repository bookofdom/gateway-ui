`import ApiRelatedAdapter from 'gateway/adapters/api-related'`

LibraryAdapter = ApiRelatedAdapter.extend
  errorMappings:
    data: 'body'

`export default LibraryAdapter`
