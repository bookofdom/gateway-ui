module.exports = function(app) {
  var express = require('express');
  var sessionsRouter = express.Router();

  var credentials = [{
    email: 'jeff@anypresence.com',
    password: 'password'
  }, {
    email: 'test@foo.com',
    password: 'foobar'
  }];

  sessionsRouter.post('/', function(req, res) {
    var body = req.body;
    var matched = false;
    credentials.forEach(function (credential) {
      if ((body.email == credential.email) && (body.password == credential.password)) {
        matched = true;
      }
    });
    if (matched) {
      res.status(200).end();
    } else if (body.email != credentials.email) {
      res.status(400).send({error: 'No user with that email.'}).end();
    } else {
      res.status(400).send({error: 'Invalid password.'}).end();
    }
  });

  app.use('/admin/sessions', sessionsRouter);
};
