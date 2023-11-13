/*CRIAÇÃO DE TABELAS*/

CREATE TABLE Cursos (
cod_curso INT PRIMARY KEY IDENTITY,
nome varchar (30)
);

CREATE TABLE Instrutores (
cod_instrutor INT PRIMARY KEY IDENTITY,
nome varchar (30),
idade INT,
telefone varchar (14),
sexo varchar (1)
);

CREATE TABLE Turmas (
cod_turma INT PRIMARY KEY IDENTITY,
cod_curso varchar (3),
cod_instrutor INT,
telefone money
);

CREATE TABLE Alunos (
cod_aluno INT PRIMARY KEY IDENTITY,
nome varchar (30),
idade INT,
telefone varchar (14),
sexo varchar (1)
);

CREATE TABLE Matriculas (
cod_turma int IDENTITY,
cod_aluno int,
PRIMARY KEY (cod_turma, cod_aluno)
);

CREATE TABLE Aulas (
cod_turma int IDENTITY,
data datetime,
paga varchar(1),
PRIMARY KEY (cod_turma, data)
);

CREATE TABLE Frequencias (
cod_turma int IDENTITY,
cod_aluno int,
data datetime,
presente varchar(1),
PRIMARY KEY (cod_turma, cod_aluno, data)
);

/*CRIAÇÃO DE FOREIGN KEYS*/

ALTER TABLE CURSOS
ADD CONSTRAINT FK_TURMAS_CURSOS FOREIGN KEY (COD_CURSO) REFERENCES TURMAS(COD_TURMA);

ALTER TABLE INSTRUTORES
ADD CONSTRAINT FK_TURMAS_INSTRUTORES FOREIGN KEY (COD_INSTRUTOR) REFERENCES TURMAS(COD_TURMA);

ALTER TABLE Matriculas
ADD CONSTRAINT FK_Frenquencias_Matriculas FOREIGN KEY (COD_TURMA, COD_ALUNO) REFERENCES Frequencias(COD_TURMA, COD_ALUNO);

ALTER TABLE Aulas
ADD CONSTRAINT FK_Frenquencias_Aulas FOREIGN KEY (COD_TURMA, DATA) REFERENCES Frequencias(COD_TURMA, DATA);




DELETE FROM Cursos
SELECT * FROM Instrutores
sp_help Cursos