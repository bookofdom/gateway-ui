`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`
`import t from 'gateway-ui/helpers/i18n'`

BsTableComponent = BsBaseComponent.extend
  tagName: 'div'
  classNames: ['table-responsive']
  striped: false
  bordered: false
  hover: true
  condensed: false
  headings: null
  'headings-text': Ember.computed 'headings', ->
    headings = @get('headings')?.split(',') or []
    for heading in headings
      t heading.trim()

`export default BsTableComponent`
