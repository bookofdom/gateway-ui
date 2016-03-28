module.exports = function(app) {
  var express = require('express');
  var sessionsRouter = express.Router();

  var credentials = [{
    email: 'jeff@anypresence.com',
    password: 'password'
  }, {
    email: 'test@foo.com',
    password: 'foobar',
    admin: true
  }];

  sessionsRouter.post('/', function(req, res) {
    var body = req.body;
    var match = null;
    credentials.forEach(function (credential) {
      if ((body.email == credential.email) && (body.password == credential.password)) {
        match = credential;
      }
    });
    if (match) {
      res.status(200).send({user: match}).end();
    } else if (body.email != credentials.email) {
      res.status(400).send({error: 'No user with that email.'}).end();
    } else {
      res.status(400).send({error: 'Invalid password.'}).end();
    }
  });

  app.use('/admin/sessions', sessionsRouter);
};
