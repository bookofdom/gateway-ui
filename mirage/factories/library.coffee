`import { Factory, faker } from 'ember-cli-mirage'`

LibraryFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()} Library"
  description: -> faker.lorem.sentence()
  data: '''/**
* Description of this fn
* @param {string} name - document name
* @param {string} doc - content
* @returns {number} the product of the passed parameters
*/
function libraryOne (name, doc) {};
  '''

`export default LibraryFactory`
