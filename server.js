const express = require('express')
const fs = require('fs')
const getStat = require('util').promisify(fs.stat)

const mongoose = require('mongoose')
const Empresa = mongoose.model('Empresa')
const Avaliacao = mongoose.model('Avaliacao')
const Usuario = mongoose.model('Usuario')

require('./models/index')

const app = express()

app.use(express.static('public'))

//Empresas
app.post('/createEmpresa', async (req, res) => {

})
app.get('/empresas', async (req, res) => {

})
app.get('/empresaNome/: id', async (req, res) => {

})

//Avaliacao
app.post('createAvaliacao', async (req, res) => {

})
app.get('avaliacao', async (req, res) =>{

})
app.put('updateAvaliacao/: id', async (req, res) => {

})
app.delete('deleteAvaliacao/: id', async (req, res) =>{

})

//Usuario
app.post('createUsuario', async (req, res) =>{

})
app.get('usuario/: id', async(req, res) =>{

})
app.put('updateUsuario/: id', async(req, res) =>{

})
app.delete('deleteUsuario/: id', async (req, res)=>{
    
})


