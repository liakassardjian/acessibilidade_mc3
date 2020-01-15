const mongoose = require('mongoose')
const Schema = mongoose.Schema
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate')


const Usuario = new Schema({
  uuid: {
    type: String,
    required: true
  },
  senha: {
    type: String
  },
  nome: {
    type: String
  },
  email: {
    type: String,
    unique: true
  },
  
  //relacionamento com usuario
  avaliacaoDoUsuario: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Avaliacao',
    autopopulate: true
  }]
})

Usuario.methods.checkPassword = function (senha) {
  let resut = this.senha === md5(senha)
  return resut
}

Usuario.methods.hashPassword = function (senha) {
  return md5(senha)
}

Usuario.plugin(autopopulate)
mongoose.model('Usuario', Usuario)