`import Ember from 'ember'`
`import DS from 'ember-data'`
`import AfterSaveMixin from '../mixins/after-save'`
`import CancelableChangesMixin from '../mixins/cancelable-changes'`
`import StainedByChildrenMixin from '../mixins/stained-by-children/stained-by-children'`
`import CleanEmbeddedChildrenMixin from '../mixins/stained-by-children/clean-embedded-children'`

Model = DS.Model.extend AfterSaveMixin,
  CancelableChangesMixin,
  StainedByChildrenMixin,
  CleanEmbeddedChildrenMixin

`export default Model`
