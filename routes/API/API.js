var express = require('express');
var router = express.Router();
const mongoose = require('mongoose')
const User = mongoose.model('User')


/* GET home page. */
router.get('/', function (req, res, next) {
    res.send('Api Funcionando!');
});

router.post('/register', async function (req, res, next) {
    try {
        let newUser = new User(req.body)
        newUser.password = newUser.hashPassword(newUser.password)
        await newUser.save()
        res.json({ result: true })
    } catch (err) {
        console.log('Error: ', err)
        res.json({ result: false })
    }
});

router.post('/login', async function (req, res, next) {
    let email = req.body.email
    let password = req.body.password

    try {
        let user = await User.findOne({
            email: email
        }).exec()
        if (user && user.checkPassword(password)) {
            res.json(user)
        } else {
            res.json({ result: false })
        }
    } catch (err) {
        res.json({ result: false })
    }
});



module.exports = router;


