const mongoose = require('mongoose')
const Schema = mongoose.Schema
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate')


const Usuario = new Schema({
  uuid: {
    type: String,
    required: true
  },
  //   nome: {
  //   type: String,
  //    required: true
  //  },
  // email: {
  //   type: String,
  //   required: true,
  //   unique: true
  // },
  // salario: {
  //   type: Number,
  //   required: true,
  //   unique: true
  // },
  // cargo: {
  //   type: Number,
  //   required: true,
  //   unique: true
  // },
  avaliacaoDoUsuario: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Avaliacao',
    autopopulate: true
  }]
})

// Usuario.methods.checkPassword = function (password) {
//   let resut = this.password === md5(password)
//   return resut
// }

// Usuario.methods.hashPassword = function (password) {
//   return md5(password)
// }

Usuario.plugin(autopopulate)
mongoose.model('Usuario', Usuario)