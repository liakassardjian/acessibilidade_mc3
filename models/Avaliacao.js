const mongoose = require('mongoose')
const Schema = mongoose.Schema
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate')


const Avaliacao = new Schema({
  titulo: {
    type: String,
    required: true
  },
  data: {
    type: Date,
    required: true
  },
  cargo: {
    type: String,
    required: true
  },
  tempoServico: {
    type: Number,
    required: true
  },
  pros: {
    type: String,
    required: true
  },
  contras: {
    type: String,
    required: true
  },
  melhorias: {
    type: String
  },
  ultimoAno: {
    type: Number,
    required: true
  },
  recomenda: {
    type: Boolean,
    required: true
  },
  //Categoria
  integracaoEquipe: {
    type: Number,
    required: true
  },
  culturaValores: {
    type: Number,
    required: true
  },
  renumeracaoBeneficios: {
    type: Number,
    required: true
  },
  oportunidadeCrescimento: {
    type: Number,
    required: true
  },
  //Acessibilidade
  deficienciaMotora: {
    type: Boolean
  },
  deficienciaVisual: {
    type: Boolean
  },
  deficienciaAuditiva: {
    type: Boolean
  },
  deficienciaIntelectual: {
    type: Boolean
  },
  nanismo: {
    type: Boolean
  }
  /*usuarioDaAvaliacao: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario',
    autopopulate: true
  }*/

})

Avaliacao.plugin(autopopulate)
mongoose.model('Avaliacao', Avaliacao)