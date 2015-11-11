`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

sizes = ['xs', 'sm', 'md', 'lg']

BsColComponent = BsBaseComponent.extend
  classNameBindings: [
    'sizeClasses'
    'offsetClasses'
  ]
  sizeClasses: Ember.computed '{xs,sm,md,lg}', ->
    (for size in sizes
      "col-#{size}-#{@get size}" if @get size).compact().join ' '
  offsetClasses: Ember.computed '{xs,sm,md,lg}-offset', ->
    (for size in sizes
      offset = @get(size.toString() + '-offset')
      "col-#{size}-offset-#{offset}" if offset
    ).compact().join ' '

`export default BsColComponent`
