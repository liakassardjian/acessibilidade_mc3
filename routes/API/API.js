var express = require('express');
var router = express.Router();
const mongoose = require('mongoose')
const Usuario = mongoose.model('Usuario')
const Empresa = mongoose.model('Empresa')
const Avaliacao = mongoose.model('Avaliacao')

/* GET home page. */
router.get('/', function (req, res, next) {
    res.send('Api Funcionando!');
});

router.post('/register', async function (req, res, next) {
    try {
        let newUsuario = new Usuario(req.body)
        newUsuario.password = newUsuario.hashPassword(newUsuario.password)
        await newUsuario.save()
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
        let Usuario = await Usuario.findOne({
            email: email
        }).exec()
        if (Usuario && Usuario.checkPassword(password)) {
            res.json(Usuario)
        } else {
            res.json({ result: false })
        }
    } catch (err) {
        res.json({ result: false })
    }
});



//Empresas
//cria uma empresa
router.post('/createEmpresa', async (req, res) => {
    try {
        await Empresa.create(req.body)
        res.json(true)
    }
    catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//retorna todas as empresas
router.get('/empresas', async (req, res) => {
    let empresas = await Empresa.find({})
    res.json(empresas)
})
//retorna uma empresa
router.get('/empresaNome/:id', async (req, res) => {
    try {
        let empresa = await Empresa.findById(req.body._id)
        res.json(empresa)
    }
    catch (err){
        console.log('Error ', err)
        res.json(false)
    }
})
//deleta uma empresa
router.delete('/deleteEmpresa/:id', async (req, res) =>{
    try {
        let idEmpresa = req.body._id
        await Empresa.findByIdAndRemove(idEmpresa)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})

//Avaliacao
//cria avaliacao
router.post('/createAvaliacao', async (req, res) => {
    try {
        await Avaliacao.create(req.body)
        res.json(true)
    }
    catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//retorna todas as avaliacoes
router.get('/avaliacao', async (req, res) =>{
    let avaliacoes = await Avaliacao.find({})
    res.json(avaliacoes)
})
//faz update da avaliacao quando algo for alterado
router.put('/updateAvaliacao/:id', async (req, res) => {
    try {
        await Avaliacao.findByIdAndUpdate(req.body)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//deleta uma avaliacao
router.delete('/deleteAvaliacao/:id', async (req, res) =>{
    try {
        let idAvaliacao = req.body._id
        await Avaliacao.findByIdAndRemove(idAvaliacao)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})

//Usuario
//cria um usuario
router.post('/createUsuario', async (req, res) =>{
    try {
        await Usuario.create(req.body)
        res.json(true)
    }
    catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//retorna um usuario em especifico
router.get('/usuario/:id', async(req, res) =>{
    try {
        let avaliacao = await Avaliacao.findById(req.body._id)
        res.json(avaliacao)
    }
    catch (err){
        console.log('Error ', err)
        res.json(false)
    }
})
//faz um update do usuario quando algo for mudado
router.put('/updateUsuario/:id', async(req, res) =>{
    try {
        await Usuario.findByIdAndUpdate(req.body)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//deleta um usuario especifico
router.delete('/deleteUsuario/:id', async (req, res)=>{
    try {
        let idUsuario = req.body._id
        await Usuario.findByIdAndRemove(idUsuario)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})






module.exports = router;


