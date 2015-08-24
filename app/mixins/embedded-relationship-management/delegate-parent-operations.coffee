`import Ember from 'ember'`

# TODO
#
# Get possible parents:
# Inspect each belongs-to relationship to see if it is
# the parent by embedding this record within it.
#
# Get actual parent:
# Since multiple models could embed this record, find the first possible
# parent with a non-null value.
#
# Call the delegated method on the parent.  Parent implicitly repeats process,
# resulting in the operation resolving on the first unembedded ancestor.

DelegateEmbeddedParentOperationsMixin = Ember.Mixin.create()

`export default DelegateParentOperationsMixin`
