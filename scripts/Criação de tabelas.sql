/*CRIAÇÃO DE TABELAS*/

CREATE DATABASE Academico
GO

CREATE TABLE CURSOS (cod_curso varchar(3) primary key,
					 nome varchar(20) not null);
GO

CREATE TABLE INSTRUTORES(cod_instrutor int primary key identity(1,1),
						 nome varchar(30) not null,
						 idade int not null,
						 telefone varchar(14) null,
						 sexo varchar(1) not null);
GO

CREATE TABLE TURMAS(cod_turma varchar(9) primary key,
					cod_curso varchar(3) not null,
					cod_instrutor int not null,
					valor_aula money not null
					CONSTRAINT FK_TURMA_CURSOS FOREIGN KEY(cod_curso) REFERENCES cursos(cod_curso),
					CONSTRAINT FK_TURMA_INSTRUTORES FOREIGN KEY(cod_instrutor) REFERENCES instrutores(cod_instrutor));
GO

CREATE TABLE ALUNOS(cod_aluno int primary key identity(1,1),
					nome varchar(30) not null,
					idade int not null,
					telefone varchar(14) null,
					sexo varchar(1) not null);
GO

CREATE TABLE MATRICULAS(cod_turma varchar(9),
						cod_aluno int
						CONSTRAINT PK_TURMA_ALUNO PRIMARY KEY(cod_turma,cod_aluno),
						CONSTRAINT FK_MATRICULA_TURMA FOREIGN KEY(cod_turma) REFERENCES turmas(cod_turma),
						CONSTRAINT FK_MATRICULA_ALUNO FOREIGN KEY(cod_aluno) REFERENCES alunos(cod_aluno));
GO

CREATE TABLE AULAS(cod_turma varchar(9),
				   data	datetime,
				   paga varchar(1) not null
				   CONSTRAINT PK_AULA_TURMA_DATA PRIMARY KEY(cod_turma,data),
				   CONSTRAINT FK_AULA_TURMA FOREIGN KEY(cod_turma) REFERENCES turmas(cod_turma));
GO

CREATE TABLE FREQUENCIAS(cod_turma varchar(9),
						 cod_aluno int,
						 data datetime,
						 presente varchar(1) not null
						 CONSTRAINT PK_FREQUENCIAS_TURMA_ALUNO_DATA PRIMARY KEY(cod_turma,cod_aluno,data),
						 CONSTRAINT FK_FREQUENCIAS_MATRICULAS FOREIGN KEY(cod_turma,cod_aluno) REFERENCES matriculas(cod_turma,cod_aluno),
						 CONSTRAINT FK_FREQUENCIAS_AULAS FOREIGN KEY(cod_turma,data) REFERENCES aulas(cod_turma,data));
GO

CREATE TABLE USUARIOS(usuario varchar(30) primary key,
					  nome varchar(50) not null,
					  senha varchar(30) not null);
GO

CREATE TABLE FUNCOES(cod_funcao varchar(6) primary key,
				     nome varchar(50) not null);
GO
CREATE TABLE PERMISSOES(usuario varchar(30),
						cod_funcao varchar(6)
						CONSTRAINT PK_PERMISSOES_USUARIO_FUNCAO PRIMARY KEY(usuario,cod_funcao),
						CONSTRAINT FK_PERMISSOES_USUARIO FOREIGN KEY(usuario) REFERENCES USUARIOS(usuario),
						CONSTRAINT FK_PERMISSOES_FUNCAO FOREIGN KEY(cod_funcao) REFERENCES FUNCOES(cod_funcao));


