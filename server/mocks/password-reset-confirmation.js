module.exports = function(app) {
  var express = require('express');
  var passwordResetConfirmationRouter = express.Router();

  passwordResetConfirmationRouter.post('/', function(req, res) {
    var body = req.body;
    if (body.password_reset_confirmation.new_password.toLowerCase() == 'error') {
      res.status(422).send({errors: {base: 'An object-level error.', new_password: 'This field is in error.'}});
    } else {
      res.status(200).send();
    }
  });

  app.use('/admin/password_reset_confirmation', passwordResetConfirmationRouter);
};
