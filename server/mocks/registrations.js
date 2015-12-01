module.exports = function(app) {
  var express = require('express');
  var registrationRouter = express.Router();

  registrationRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.registration.id = id;
    res.status(201).send(body).end();
  });

  app.use('/admin/registrations', registrationRouter);
};
