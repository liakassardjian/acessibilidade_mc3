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
router.get('/empresas', async (req, res) => {
    let empresas = await Empresa.find({})
    res.json(empresas)
})
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
router.delete('/deleteEmpresa/:id', async (req, res) =>{
    
})

//Avaliacao
router.post('/createAvaliacao', async (req, res) => {

})
router.get('/avaliacao', async (req, res) =>{

})
router.put('/updateAvaliacao/:id', async (req, res) => {

})
router.delete('/deleteAvaliacao/:id', async (req, res) =>{

})

//Usuario
router.post('/createUsuario', async (req, res) =>{

})
router.get('/usuario/: id', async(req, res) =>{

})
router.put('/updateUsuario/: id', async(req, res) =>{

})
router.delete('/deleteUsuario/: id', async (req, res)=>{
    
})






module.exports = router;


