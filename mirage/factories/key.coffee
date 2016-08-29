`import { Factory, faker } from 'ember-cli-mirage'`

KeyFactory = Factory.extend
  name: -> faker.name.firstName()
  key: -> '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyUhwUTI3q/gtSymishU8
Dcn3YmnB0k50aV/aJMW2WKY/PxinXdSeSbI9fDASa/FEn7pPcIDGsIS/Q0UreBpw
ipY8CajmkWQXeJsCpjHbgtS2rEvBbEg6K3qe1VJad9HpXt3nNlTCoqwIaaVlSVWm
emVsjL+nCb+L4poaAlmQJFFX26VgBUDL1740kh86Rij6n302eWQtNLfwJUufKxmy
Mt3Amy8A5hIsrVyr85ql9mfV1c8ohrIdgH7dUz8sFPD8iUdfJ3wf6MI2Fpqcbuv1
s6yMl/oE+cqunsuIXwiVuLknkIp/jw4xQT5+M3okZlpdDygjS0s3OIkAadXpgR7n
awIDAQAB
-----END PUBLIC KEY-----'''

`export default KeyFactory`
