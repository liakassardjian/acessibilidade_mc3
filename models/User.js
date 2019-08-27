const mongoose = require('mongoose')
const md5 = require('md5')
const Schema = mongoose.Schema
const autopopulate = require('mongoose-autopopulate')

const User = new Schema({
  nome: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  }
})

User.methods.checkPassword = function (password) {
  let resut = this.password === md5(password)
  return resut
}

User.methods.hashPassword = function (password) {
  return md5(password)
}

User.plugin(autopopulate)
mongoose.model('User', User)