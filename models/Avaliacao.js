const mongoose = require('mongoose')
const Schema = mongoose.Schema
const md5 = require('md5')
const autopopulate = require('mongoose-autopopulate')


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
    required: true,
    unique: false
  },
  contras: {
    type: String,
    required: true,
    unique: false
  },
  melhorias: {
    type: String,
    required: false,
    unique: false
  },
  ultimoAno: {
    type: Number,
    required: true,
    unique: false
  },
  recomenda: {
    type: Boolean,
    required: true,
    unique: false
  },
  //Categoria
  integracaoEquipe: {
    type: Number,
    required: true,
    unique: false
  },
  culturaValores: {
    type: Number,
    required: true,
    unique: false
  },
  renumeracaoBeneficios: {
    type: Number,
    required: true,
    unique: false
  },
  oportunidadeCrescimento: {
    type: Number,
    required: true,
    unique: false
  },
  //Acessibilidade
  deficienciaMotora: {
    type: Boolean,
    required: false,
    unique: false
  },
  deficienciaVisual: {
    type: Boolean,
    required: false,
    unique: false
  },
  deficienciaAuditiva: {
    type: Boolean,
    required: false,
    unique: false
  },
  deficienciaIntelectual: {
    type: Boolean,
    required: false,
    unique: false
  },
  nanismo: {
    type: Boolean,
    required: false,
    unique: false
  },
  usuarioDaAvaliacao: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario',
    autopopulate: true
  }

})

Avaliacao.plugin(autopopulate)
mongoose.model('Avaliacao', Avaliacao)