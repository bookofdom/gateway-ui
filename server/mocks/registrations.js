module.exports = function(app) {
  var express = require('express');
  var registrationRouter = express.Router();

  registrationRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.registration.id = id;

    if (body.registration.email.toLowerCase() == 'error') {
      res.status(422).send({errors: {email: 'This field is in error.'}});
    } else if (body.registration.email.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.status(201).send(body).end();
    }
  });

  app.use('/admin/registrations', registrationRouter);
};
