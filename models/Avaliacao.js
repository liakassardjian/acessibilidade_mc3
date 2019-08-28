const mongoose = require('mongoose')
const md5 = require('md5')


const Avaliacao = new Schema({
  titulo: {
    type: String,
    required: true,
    unique: false
  },
  data: {
    type: Date,
    required: true,
    unique: false
  },
  cargo: {
    type: String,
    required: true,
    unique: false
  },
  tempoServico: {
    type: Number,
    required: true,
    unique: false
  },
  pros: {
    type: String,
    require: true,
    unique: false
  },
  contras: {
    type: String,
    require: true,
    unique: false
  },
  melhorias: {
    type: String,
    require: false,
    unique: false
  },
  ultimoAno: {
    type: Number,
    require: true,
    unique: false
  },
  recomenda: {
    type: Boolean,
    require: true,
    unique: false
  },
  //Categoria
  integracaoEquipe: {
    type: Number,
    require: true,
    unique: false
  },
  culturaValores: {
    type: Number,
    require: true,
    unique: false
  },
  renumeracaoBeneficios: {
    type: Number,
    require: true,
    unique: false
  },
  oportunidadeCrescimento: {
    type: Number,
    require: true,
    unique: false
  },
  //Acessibilidade
  deficienciaMotora: {
    type: Boolean,
    require: false,
    unique: false
  },
  deficienciaVisual: {
    type: Boolean,
    require: false,
    unique: false
  },
  deficienciaAuditiva: {
    type: Boolean,
    require: false,
    unique: false
  },
  deficienciaIntelectual: {
    type: Boolean,
    require: false,
    unique: false
  },
  nanismo: {
    type: Boolean,
    require: false,
    unique: false
  }

})


mongoose.model('Avaliacao', Avaliacao)