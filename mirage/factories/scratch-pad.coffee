`import { Factory, faker } from 'ember-cli-mirage'`

ScratchPadFactory = Factory.extend
  name: (i) -> "Scratch Pad #{i}"
  code: (i) -> "foo('Test #{i}');"

`export default ScratchPadFactory`
