module.exports = function(app) {
  var express = require('express');
  var sessionsRouter = express.Router();
  
  var credentials = {
    email: 'jeff@anypresence.com',
    password: 'password'
  };
  
  sessionsRouter.post('/', function(req, res) {
    var body = req.body;
    if ((body.email == credentials.email) && (body.password == credentials.password)) {
      res.status(200).end();
    } else if (body.email != credentials.email) {
      res.status(400).send('No user with that email.').end();
    } else {
      res.status(400).send('Invalid password.').end();
    }
  });

  app.use('/admin/sessions', sessionsRouter);
};
