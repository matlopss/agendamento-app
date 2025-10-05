-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER');

-- CreateTable
CREATE TABLE "Cliente" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "telefone" TEXT NOT NULL,
    "email" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profissional" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "Profissional_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Servico" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "duracaoMin" INTEGER NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "profissionalId" INTEGER NOT NULL,

    CONSTRAINT "Servico_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HorarioPadrao" (
    "id" SERIAL NOT NULL,
    "diaSemana" INTEGER NOT NULL,
    "horaInicio" TEXT NOT NULL,
    "horaFim" TEXT NOT NULL,
    "profissionalId" INTEGER NOT NULL,

    CONSTRAINT "HorarioPadrao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HorarioExcecao" (
    "id" SERIAL NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "tipo" TEXT NOT NULL,
    "horaInicio" TEXT,
    "horaFim" TEXT,
    "motivo" TEXT,
    "profissionalId" INTEGER NOT NULL,

    CONSTRAINT "HorarioExcecao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HorarioGerado" (
    "id" SERIAL NOT NULL,
    "dataHora" TIMESTAMP(3) NOT NULL,
    "disponivel" BOOLEAN NOT NULL DEFAULT true,
    "reservadoPara" INTEGER,
    "profissionalId" INTEGER NOT NULL,

    CONSTRAINT "HorarioGerado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Agendamento" (
    "id" SERIAL NOT NULL,
    "clienteId" INTEGER NOT NULL,
    "servicoId" INTEGER NOT NULL,
    "horarioId" INTEGER NOT NULL,
    "dataHora" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Agendamento_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "Profissional"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HorarioPadrao" ADD CONSTRAINT "HorarioPadrao_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "Profissional"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HorarioExcecao" ADD CONSTRAINT "HorarioExcecao_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "Profissional"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HorarioGerado" ADD CONSTRAINT "HorarioGerado_profissionalId_fkey" FOREIGN KEY ("profissionalId") REFERENCES "Profissional"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agendamento" ADD CONSTRAINT "Agendamento_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agendamento" ADD CONSTRAINT "Agendamento_servicoId_fkey" FOREIGN KEY ("servicoId") REFERENCES "Servico"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agendamento" ADD CONSTRAINT "Agendamento_horarioId_fkey" FOREIGN KEY ("horarioId") REFERENCES "HorarioGerado"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
