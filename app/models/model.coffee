`import Ember from 'ember'`
`import DS from 'ember-data'`

Model = DS.Model.extend
  # TODO
  # Revert to DS.Model.  This method is taken from beta15.  However, beta15
  # can't be used because it breaks belongsto serialization.  It breaks it
  # because it introduces a brand new API (snapshots) for serialization.
  # Obviously, introducing a brand new API in the middle of a beta cycle is not
  # a good idea.  Oh well.
  adapterDidInvalidate: (errors) ->
    recordErrors = Ember.get @, 'errors'
    for key of errors
      if !errors.hasOwnProperty key
        continue
      recordErrors.add key, errors[key]
    @_saveWasRejected()

`export default Model`
