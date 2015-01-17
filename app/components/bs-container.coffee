`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

BsContainerComponent = BsBaseComponent.extend
  classNameBindings: ['fluid:container-fluid:container']
  fluid: true

`export default BsContainerComponent`
