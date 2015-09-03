FileReaderInitializer =
  name: 'file-reader-service'
  initialize: (container, app) ->
    app.inject 'component', 'fileReaderService', 'service:file-reader'

`export default FileReaderInitializer`
