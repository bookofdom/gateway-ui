`import Ember from 'ember'`
`import DS from 'ember-data'`

`import LifecycleHooksMixin from '../mixins/lifecycle-hooks'`
`import CancelableChangesMixin from '../mixins/cancelable-changes'`

`import EmbeddedChildrenMixin from '../mixins/embedded-relationship-management/embedded-children'`
`import CleanEmbeddedChildrenMixin from '../mixins/embedded-relationship-management/clean-embedded-children'`
`import DelegateEmbeddedOperationsMixin from '../mixins/embedded-relationship-management/delegate-embedded-operations'`
`import StainedByChildrenMixin from '../mixins/embedded-relationship-management/stained-by-children'`

Model = DS.Model.extend LifecycleHooksMixin,
  CancelableChangesMixin,
  EmbeddedChildrenMixin,
  CleanEmbeddedChildrenMixin,
  DelegateEmbeddedOperationsMixin,
  StainedByChildrenMixin

`export default Model`
