`import { Factory, faker } from 'ember-cli-mirage'`

callId = 1
transformationId = 1

types = 'single multi js shared'.split ' '
typeCycle = faker.list.cycle types...

ProxyEndpointComponentFactory = Factory.extend
  proxy_endpoint_component_id: -> faker.random.number() # passthrough ID
  name: -> "#{faker.company.catchPhraseAdjective().capitalize()} Component"
  description: -> faker.lorem.sentence()
  conditional_positive: -> faker.random.boolean()
  data: 'foo("code string");'
  conditional: '''
var foo = function () {
  var someCondition = true;
  var myInt = 25;
  if (someCondition && myInt) {
    this.makeACall();
    return {
      key_1: 'this is a string',
      key_2: myInt,
      key_3: MyOtherClass.getString('some_value')
    };
  }
};
'''
  type: (i) ->
    typeSlug = typeCycle i
    if typeSlug is 'shared'
      @shared_component_id = (faker.random.number() % 10) + 1
    if (typeSlug != 'shared') and (typeSlug != 'js')
      # single and multi have before/after transformations
      @before = [
        id: transformationId++
        type: 'js'
        data: "before #{typeSlug}"
      ]
      @after = [
        id: transformationId++
        type: 'js'
        data: "after #{typeSlug}"
      ]
      # single and multi store calls differently
      call =
        remote_endpoint_id: (faker.random.number() % 28) + 1
        endpoint_name_override: "#{typeSlug}Override"
        conditional: 'foo("call conditional");'
        conditional_positive: faker.random.boolean()
        before: [
          id: transformationId++
          type: 'js'
          data: "before #{typeSlug} call"
        ]
        after: [
          id: transformationId++
          type: 'js'
          data: "after #{typeSlug} call"
        ]
      @call = call if typeSlug is 'single'
      @calls = [call] if typeSlug is 'multi'
    typeSlug

`export default ProxyEndpointComponentFactory`
