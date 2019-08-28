const mongoose = require('mongoose')
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate');


const Empresa = new Schema({
  nome: {
    type: String,
    required: true,
    unique: true
  },
  site: {
    type: String,
    required: false,
    unique: true
  },
  telefone: {
    type: String,
    required: false,
    unique: true
  },
  media: {
    type: Number,
    required: false,
    unique: false
  },
  mediaRecomendacao: {
    type: Number,
    required: false,
    unique: false
  },
  //localizacao
  cidade: {
    type: String,
    required: true,
    unique: false
  },
  estado: {
    type: String,
    required: true,
    unique: false
  }, 
  avaliacao: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Avaliacao',
    autopopulate: true
  }]
})


Empresa.plugin(autopopulate)
mongoose.model('Empresa', Empresa)