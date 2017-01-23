import Ember from 'ember';

export default Ember.Helper.extend({
  i18n: Ember.inject.service(),
  compute(params, hash) {
    const path = params[0];
    return Ember.String.htmlSafe(this.get('i18n').t(path, hash).capitalize());
  },
  refreshText: Ember.observer('i18n._locale', function () {
    this.recompute();
  })
});
