`import Ember from 'ember'`
`import BsTextComponent from 'gateway/pods/components/bs-text/component'`

ApPageComponent = BsTextComponent.extend
  classNames: ['ap-page']
  'help-url': null

  scrollToBottom: ->
    Ember.run.later (->
      scrollHeight = Ember.$('body')[0]?.scrollHeight + 300
      Ember.$('body').scrollTop scrollHeight
    ), 250

  actions:
    'show-new': ->
      @scrollToBottom()
      panelNew = @$().find '.ap-panel-new'
      isOpen = panelNew.find('.in').length
      panelNew.find('[data-toggle="collapse"]').click() if !isOpen

`export default ApPageComponent`
