const path = require('path');
const express = require('express');
const Sequelize = require('sequelize');
const bodyParser = require('body-parser');

const apiKey = require('./secret.js');
console.log(apiKey);
var stripe = require('stripe')(apiKey);

const email = 'demo@domain.fr';

const sequelize = new Sequelize('example', 'username', 'password', {
  host: 'localhost',
  dialect: 'sqlite',
  storage: path.join(__dirname, 'database.sqlite'),
});

const User = sequelize.define('user', {
  email: {
    type: Sequelize.STRING,
  },
  stripeId: {
    type: Sequelize.STRING,
  },
});

User.sync({ force: true }).then(() => User.create({ email }));

const app = express();
app.use(bodyParser.json());

app.post('/', function(req, res) {
  const source = req.body.token;
  User.findOne({ where: { email } })
    .then(user => {
      if (user.stripeId) {
        return stripe.customers.createSource(user.stripeId, { source }).then(() => user);
      }
      return stripe.customers.create({ email: user.email, source }).then(stripeUser => {
        user.stripeId = stripeUser.id;
        console.log(stripeUser);
        return user.save();
      });
    })
    .then(user => stripe.customers.listCards(user.stripeId))
    .then(cards => {
      res.send(cards);
    });
});

app.listen(3000, function() {
  console.log('Example app listening on port 3000!');
});
