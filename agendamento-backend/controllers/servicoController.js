const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.criarServico = async (req, res) => {
  const { nome, duracaoMin, preco, profissionalId } = req.body;
  try {
    const servico = await prisma.servico.create({
      data: { nome, duracaoMin, preco, profissionalId },
    });
    res.json(servico);
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao criar serviço', detalhes: error.message });
  }
};

exports.listarServicos = async (req, res) => {
  try {
    const servicos = await prisma.servico.findMany();
    res.json(servicos);
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao listar serviços', detalhes: error.message });
  }
};