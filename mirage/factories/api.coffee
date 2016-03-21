`import { Factory } from 'ember-cli-mirage'`

ApiFactory = Factory.extend
  name: (i) -> "API #{i}"
  base_url: (i) -> "http://www.api-#{i}.com"

`export default ApiFactory`
