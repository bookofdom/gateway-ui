`import Ember from 'ember'`
`import DS from 'ember-data'`
`import LifecycleHooksMixin from '../mixins/lifecycle-hooks'`
`import CancelableChangesMixin from '../mixins/cancelable-changes'`
`import StainedByChildrenMixin from '../mixins/embedded-relationship-management/stained-by-children'`
`import CleanEmbeddedChildrenMixin from '../mixins/embedded-relationship-management/clean-embedded-children'`
`import DelegateParentOperationsMixin from '../mixins/embedded-relationship-management/delegate-parent-operations'`

Model = DS.Model.extend LifecycleHooksMixin,
  CancelableChangesMixin,
  StainedByChildrenMixin,
  CleanEmbeddedChildrenMixin,
  DelegateParentOperationsMixin

`export default Model`
