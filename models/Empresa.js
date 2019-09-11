const mongoose = require('mongoose')
const Schema = mongoose.Schema
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate')


const Empresa = new Schema({
  nome: {
    type: String,
    required: true,
    unique: true
  },
  site: {
    type: String,
    unique: true
  },
  telefone: {
    type: String,
    unique: true
  },
  media: {
    type: Number,
  },
  mediaRecomendacao: {
    type: Number
  },
  //localizacao
  cidade: {
    type: String,
    required: true,
  },
  estado: {
    type: String,
    required: true,
  }, 
  //relacionamento com avaliacao
  avaliacao: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Avaliacao',
    autopopulate: true
  }]
})


Empresa.plugin(autopopulate)
mongoose.model('Empresa', Empresa)