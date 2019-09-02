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
router.post('/createEmpresa', async (req, res) => {//funciona
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
router.get('/empresas', async (req, res) => {//funciona
    let empresas = await Empresa.find({})
    res.json(empresas)
})
//retorna uma empresa
router.get('/empresaNome/:id', async (req, res) => {//funciona
    try {
        let empresa = await Empresa.findById(req.params.id)
        res.json(empresa)
    }
    catch (err){
        console.log('Error ', err)
        res.json(false)
    }
})
//deleta uma empresa
router.delete('/deleteEmpresa/:id', async (req, res) =>{//funciona
    try {
        let idEmpresa = req.params.id
        await Empresa.findByIdAndRemove(idEmpresa)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})

//Avaliacao
//cria avaliacao
router.post('/createAvaliacao', async (req, res) => {//funciona
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
router.get('/avaliacao', async (req, res) =>{//funciona
    let avaliacoes = await Avaliacao.find({})
    res.json(avaliacoes)
})

//faz UPDATE da avaliacao quando algo for alterado
router.post('/updateAvaliacao/:id', async (req, res) => {//funcionando
    try {
        await Avaliacao.findByIdAndUpdate(req.params.id, req.body)
        res.json(true)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

//deleta uma avaliacao
router.delete('/deleteAvaliacao/:id', async (req, res) =>{//funcionando
    try {
        let idAvaliacao = req.params.id
        await Avaliacao.findByIdAndRemove(idAvaliacao)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})

//Usuario
//cria um usuario
router.post('/createUsuario', async (req, res) =>{//funciona
    try {
        await Usuario.create(req.body)
        res.json(true)
    }
    catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})
//retorna todos os usuarios
router.get('/todosUsuarios', async (req, res) =>{//funcionando
    let usuarios = await Usuario.find({})
    res.json(usuarios)
})

//retorna um usuario em especifico
router.get('/usuario/:uuid', async(req, res) =>{//funcionando
    try {
        let usuario = await Usuario.findOne({uuid: req.params.uuid})
        res.json(usuario)
    }
    catch (err){
        console.log('Error ', err)
        res.json(false)
    }
})
//faz um UPDATE do usuario quando algo for mudado
router.post('/updateUsuario/:uuid', async(req, res) =>{//funciona
    try {
        await Usuario.findOneAndUpdate({uuid: req.params.uuid}, req.body)
        res.json(true)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

//deleta um usuario especifico
router.delete('/deleteUsuario/:uuid', async (req, res)=>{//funciona
    try {
        let idUsuario = {uuid: req.params.uuid}
        await Usuario.findOneAndDelete(idUsuario)
        res.json(true)
        
    } catch (err) {
        console.log('Error: ', err)
        res.json(false) 
    }
})






module.exports = router;


