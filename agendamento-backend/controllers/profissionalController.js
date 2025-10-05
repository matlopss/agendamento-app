const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.criarProfissional = async (req, res) => {
  const { nome } = req.body;
  try {
    const profissional = await prisma.profissional.create({
      data: { nome },
    });
    res.json(profissional);
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao criar profissional', detalhes: error.message });
  }
};

exports.listarProfissionais = async (req, res) => {
  try {
    const profissionais = await prisma.profissional.findMany();
    res.json(profissionais);
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao listar profissionais', detalhes: error.message });
  }
};