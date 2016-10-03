`import Ember from 'ember'`
`import BsPanelComponent from 'gateway/pods/components/bs-panel/component'`
`import t from 'gateway/helpers/i18n'`

ApPanelEditComponent = BsPanelComponent.extend
  classNames: ['ap-panel-edit']
  style: 'default'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    t('actions.edit-x', x: translationKey) if translationKey

`export default ApPanelEditComponent`
