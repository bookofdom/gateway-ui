import Ember from 'ember';

export default function destroyApp(application) {
  Ember.run(application, 'destroy');
  // Manually shutdown pretender after each test or else tests will hang:
  // https://github.com/samselikoff/ember-cli-mirage/issues/142
  server.pretender.shutdown();
  server.shutdown();
}
