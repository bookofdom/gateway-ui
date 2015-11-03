module.exports = function(app) {
  var express = require('express');
  var usersRouter = express.Router();
  var users = [
    {
      id: 1,
      name: 'Admin',
      email: 'test@foo.com'
    },
    {
      id: 2,
      name: 'Sally Field',
      email: 'fields_of@sally.com'
    }
  ]

  usersRouter.get('/', function(req, res) {
    res.send({
      'users': users
    });
  });

  usersRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.user.id = id;
    res.status(201).send(body).end();
  });

  usersRouter.get('/:id', function(req, res) {
    var user = users.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'user': user[0]
    });
  });

  usersRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.user.id = req.params.id;
    if (body.user.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  usersRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/users', usersRouter);
};
