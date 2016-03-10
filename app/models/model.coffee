`import Ember from 'ember'`
`import DS from 'ember-data'`

`import LifecycleHooksMixin from 'gateway/mixins/lifecycle-hooks'`
`import CancelableChangesMixin from 'gateway/mixins/cancelable-changes'`

`import EmbeddedChildrenMixin from 'gateway/mixins/embedded-relationship-management/embedded-children'`
`import EmbeddedErrorsMixin from 'gateway/mixins/embedded-relationship-management/embedded-errors'`
`import CleanEmbeddedChildrenMixin from 'gateway/mixins/embedded-relationship-management/clean-embedded-children'`
`import DelegateEmbeddedOperationsMixin from 'gateway/mixins/embedded-relationship-management/delegate-embedded-operations'`
`import StainedByChildrenMixin from 'gateway/mixins/embedded-relationship-management/stained-by-children'`

Model = DS.Model.extend LifecycleHooksMixin,
  CancelableChangesMixin,
  EmbeddedChildrenMixin,
  EmbeddedErrorsMixin,
  CleanEmbeddedChildrenMixin,
  DelegateEmbeddedOperationsMixin,
  StainedByChildrenMixin,

  session: Ember.inject.service()

`export default Model`
