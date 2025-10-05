const express = require('express');
const router = express.Router();
const servicoController = require('../controllers/servicoController');

router.post('/', servicoController.criarServico);
router.get('/', servicoController.listarServicos);

module.exports = router;