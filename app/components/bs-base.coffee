`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'visibileBlockClasses'
    'visibileInlineClasses'
    'visibileInlineBlockClasses'
    'hiddenClasses'
  ]
  sizes: ['xs', 'sm', 'md', 'lg']
  visibileBlockClasses: Ember.computed 'visible-{xs,sm,md,lg}-block', ->
    (for size in @get 'sizes'
      visibleClass = "visible-#{size}-block"
      visibleClass if @get visibleClass
    ).compact().join ' '
  visibileInlineClasses: Ember.computed 'visible-{xs,sm,md,lg}-inline', ->
    (for size in @get 'sizes'
      visibleClass = "visible-#{size}-inline"
      visibleClass if @get visibleClass
    ).compact().join ' '
  visibileInlineBlockClasses: Ember.computed 'visible-{xs,sm,md,lg}-inline-block', ->
    (for size in @get 'sizes'
      visibleClass = "visible-#{size}-inline-block"
      visibleClass if @get visibleClass
    ).compact().join ' '
  hiddenClasses: Ember.computed 'hidden-{xs,sm,md,lg}', ->
    (for size in @get 'sizes'
      hiddenClass = "hidden-#{size}"
      hiddenClass if @get hiddenClass
    ).compact().join ' '

`export default BsBaseComponent`
