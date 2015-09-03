`import Ember from 'ember'`

FileReaderService = Ember.Object.extend
  # Returns a promise that reads a file, converts it to a data URI, and resolves
  # with the result.
  readToDataURI: (file) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      reader = new FileReader()
      reader.onload = (e) -> resolve e.target.result
      reader.readAsDataURL file

`export default FileReaderService`
