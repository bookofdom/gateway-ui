`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'active'
    'disabled'
    'clearfix'
    'visibileBlockClasses'
    'visibileInlineClasses'
    'visibileInlineBlockClasses'
    'hiddenClasses'
    'pullClass'
    'textAlignmentClass'
    'textTransformClass'
    'textContextClass'
    'bgContextClass'
  ]
  sizes: ['xs', 'sm', 'md', 'lg']
  stateNames: ['primary', 'success', 'info', 'warning', 'danger']
  active: false
  disabled: false
  clearfix: false
  left: false
  right: false
  'text-left': false
  'text-right': false
  'text-center': false
  lowercase: false
  uppercase: false
  capitalize: false
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
  pullClass: Ember.computed '{left,right}', ->
    if @get 'left'
      'pull-left'
    else if @get 'right'
      'pull-right'
  textAlignmentClass: Ember.computed 'text-{left,right,center}', ->
    if @get 'text-left'
      'text-left'
    else if @get 'text-right'
      'text-right'
    else if @get 'text-center'
      'text-center'
  textTransformClass: Ember.computed '{lowercase,uppercase,capitalize}', ->
    if @get 'lowercase'
      'text-lowercase'
    else if @get 'uppercase'
      'text-uppercase'
    else if @get 'capitalize'
      'text-capitalize'
  textContextClass: Ember.computed 'text-{muted,primary,success,info,warning,danger}', ->
    states = @get 'stateNames'
    states.push 'muted'
    (for state in states
      stateClass = "text-#{state}"
      stateClass if @get stateClass
    ).compact().join ' '
  bgContextClass: Ember.computed 'bg-{primary,success,info,warning,danger}', ->
    (for state in @get 'stateNames'
      stateClass = "bg-#{state}"
      stateClass if @get stateClass
    ).compact().join ' '

`export default BsBaseComponent`
