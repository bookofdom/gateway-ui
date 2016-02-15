FileReaderInitializer =
  name: 'file-reader-service'
  initialize: (app) ->
    app.inject 'component', 'fileReaderService', 'service:file-reader'

`export default FileReaderInitializer`
