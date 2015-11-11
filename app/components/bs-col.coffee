`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

sizes = ['xs', 'sm', 'md', 'lg']

BsColComponent = BsBaseComponent.extend
  classNameBindings: [
    'sizeClasses'
    'offsetClasses'
    'pushClasses'
    'pullClasses'
  ]
  sizeClasses: Ember.computed '{xs,sm,md,lg}', ->
    (for size in sizes
      "col-#{size}-#{@get size}" if @get size).compact().join ' '
  offsetClasses: Ember.computed '{xs,sm,md,lg}-offset', ->
    (for size in sizes
      offset = @get(size.toString() + '-offset')
      "col-#{size}-offset-#{offset}" if offset
    ).compact().join ' '
  pushClasses: Ember.computed '{xs,sm,md,lg}-push', ->
    (for size in sizes
      push = @get(size.toString() + '-push')
      "col-#{size}-push-#{push}" if push
    ).compact().join ' '
  pullClasses: Ember.computed '{xs,sm,md,lg}-pull', ->
    (for size in sizes
      pull = @get(size.toString() + '-pull')
      "col-#{size}-pull-#{pull}" if pull
    ).compact().join ' '

`export default BsColComponent`
