module.exports = function(app) {
  var express = require('express');
  var passwordResetRouter = express.Router();

  passwordResetRouter.post('/', function(req, res) {
    var body = req.body;
    if (body.password_reset.email.toLowerCase() == 'error') {
      res.status(422).send({errors: {base: 'An object-level error.', email: 'This field is in error.'}});
    } else {
      res.status(200).send();
    }
  });

  app.use('/admin/password_reset', passwordResetRouter);
};
