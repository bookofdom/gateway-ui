import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['modal'],

  classNameBindings: ['fade:fade'],

  hideClass: 'hide.bs.modal',
  hiddenClass: 'hidden.bs.modal',

  keyboard: true,
  backdrop: true,

  closeAfterSuccess: true,
  closeAfterFail: false,
  staticBackdrop: false,

  doAfterClose: 'doAfterClose',
  doSave: 'doSave',
  doClose: 'doClose',

  _isSubmitting: false,
  _isClosing: false,
  _isReadyToClose: false,

  show: false,
  fade: true,

  _el: null,

  disabled: Ember.computed.or('_isSubmitting', '_isClosing'),

  backdropSetting: Ember.computed('backdrop', 'staticBackdrop',
    function() {
      var res = this.get('backdrop');

      return (res && this.get('staticBackdrop')) ? 'static' : res;
    }
  ),

  modalOptions: Ember.computed('backdropSetting', 'keyboard',
    function() {

      return {
          backdrop: this.get('backdropSetting'),
          keyboard: this.get('keyboard')
      };
    }
  ),

  _isReadyToCloseChanged: Ember.observer('_isReadyToClose',
    function() {

      if(this.get('_isReadyToClose')) {
        this.get('_el').modal('hide');
      }
    }
  ),

  _closeAfterType: function(resolved) {
    return resolved ? this.get('closeAfterSuccess') : this.get('closeAfterFail');

  },

  _onSubmitCallback: function(resolved) {

    if(this._closeAfterType(resolved)) {
      this.set('_isReadyToClose', true);

    } else {
      this.set('_isSubmitting', false);
    }

  },

  actions: {

    submit(meta) {

      var self = this,
        defer = Ember.RSVP.defer();

      self.set('_isSubmitting', true);

      defer.promise.then(
        function() {
          self._onSubmitCallback(true);
        },
        function() {
          self._onSubmitCallback(false);
        }
      );

      self.sendAction('doSave', defer, meta);
    }

  },

  isVisibleChanged: Ember.observer('isVisible',
    function() {
      if(this.get('isVisible')) {

        this.renderModal();
      } else {
        this.destroyModal();
      }

    }
  ),

  _reset: function() {

    this.setProperties({
      _isReadyToClose: false,
      _isClosing: false,
      _isSubmitting: false
    });

  },

  renderModal: function() {

    var self = this;

    self.set('_el', self.$().modal(self.get('modalOptions')));

    self.get('_el').on(self.get('hideClass'), function(e) {
      Ember.run(
        function() {

          e.stopImmediatePropagation();
          self.set('_isClosing', true);

          if(self.get('_isReadyToClose')) { return; }

          e.preventDefault();

          var defer = Ember.RSVP.defer();
          defer.promise.then(
            function() {
              self.set('_isReadyToClose', true);

            },
            function() {
              self._reset();

            }
          );

          self.sendAction('doClose', defer);

        }
      );

    });

    self.get('_el').on(self.get('hiddenClass'),
      function() {
        Ember.run(
          function() {
            self.set('isVisible', false);

            self.sendAction(self.get('doAfterClose'));

          }
        );

      }
    );

  },

  destroyModal: function() {
    this._reset();
    this.get('_el').off();
  },

  setupBootstrapModal: function() {

    this._super();
    Ember.run.scheduleOnce('afterRender', this, this.afterRenderEvent);

  }.on('didInsertElement'),

  afterRenderEvent: function() {

    if(this.get('show')) {

      this.set('isVisible', true);
    }

  },

  teardownBootstrapModal: function() {

    this.destroyModal();

  }.on('willDestroyElement')

});
