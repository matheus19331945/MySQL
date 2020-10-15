create database if not exists db_universidade;
use db_universidade;

create table if not exists tbl_aluno (
mat varchar(10) not null primary key, 
nome varchar(80) not null, 
endereco varchar(80) not null, 
cidade varchar(40) not null);

create table if not exists tbl_disciplina (
cod_disc varchar(5),
nome_disc varchar(50) not null, 
carga_hor varchar(5) not null, 
primary key (cod_disc));

create table tbl_professor (
cod_prof varchar(7) primary key,
nome varchar(60) not null, 
endereco varchar(60) not null, 
cidade varchar(60) not null);

create table if not exists tbl_turma (
cod_disc varchar(5) not null,
cod_turma varchar(4) not null, 
cod_prof varchar(7) not null, 
ano year not null,  
horario  varchar(7) not null,
primary key (cod_disc, cod_turma, cod_prof, ano),
constraint fk_turma_disc foreign key (cod_disc) references tbl_disciplina (cod_disc),
constraint fk_turma_professor foreign key (cod_prof) references tbl_professor
(cod_prof));

#Histórico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequência, nota)
# MAT referencia Alunos
 #COD_DISC, COD_TURMA, COD_PROF, ANO referencia Turma
 
create table if not exists tbl_historico(
mat varchar(10) not null,
cod_disc varchar(5) not null,
cod_turma varchar(4) not null,
cod_prof varchar(7) not null,
ano year not null,
frequencia varchar(3) not null,
nota float not null,
#declarar chave primária
primary key (mat, cod_disc, cod_turma, cod_prof, ano),
constraint fk_historico_mat foreign key (mat) references tbl_aluno (mat),
constraint fk_historico_turma foreign key (cod_disc, cod_turma, cod_prof, ano) references tbl_turma (cod_disc, cod_turma, cod_prof, ano)
);

-- popular as tabelas
insert into tbl_aluno (mat, nome, endereco, cidade) values
('2015010101', 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
('2015010102', 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
('2015010103', 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
('2015010104', 'MARIA DAS DORES', 'RUA DAS LADEIRAS','FORTALEZA'),
('2015010105', 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
('2015010106', 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

select * from tbl_aluno;

insert into tbl_disciplina (cod_disc, nome_disc, carga_hor) values
('BD', 'BANCO DE DADOS', '100'),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', '100'),
('WEB', 'AUTORIA WEB', '50'),
('ENG', 'ENGENHARIA DE SOFTWARE', '80');

select * from tbl_disciplina;

insert into tbl_professor (cod_prof, nome, endereco, cidade) values
('212131', 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
('122135', 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
('192011', 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

select * from tbl_professor;

insert into tbl_turma (cod_disc, cod_turma, cod_prof, ano, horario) values
('BD', '1', '212131', '2015', '11H-12H'),
('BD', '2', '212131', '2015', '13H-14H'),
('POO', '1', '192011', '2015', '08H-09H'),
('WEB', '1', '192011', '2015', '07H-08H'),
('ENG', '1', '122135', '2015', '10H-11H');

select * from tbl_turma;

#alterando o tamanho frequencia para varchar 4
alter table tbl_historico
modify column frequencia varchar(4);

#frequência é o percentual
insert into tbl_historico (mat, cod_disc, cod_turma, cod_prof, ano, frequencia, nota) values
('2015010103', 'WEB', '1', '212131', '2015', '30', 8.0);

insert into tbl_historico (mat, cod_disc, cod_turma, cod_prof, ano, frequencia, nota) values
('2015010102', 'POO', '1', '192011', '2015', '30%', 7.0),
('2015010103', 'WEB', '1', '192011', '2015', '40%', 10.0),
('2015010104', 'ENG', '1', '122135', '2015', '60%', 4.0),
('2015010105', 'BD', '2', '212131', '2015', '80%', 3.5),
('2015010106', 'BD', '1', '212131', '2015', '100%', 9.0);

select * from tbl_historico;

#a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD =
#código da disciplinas).
select mat from tbl_historico where cod_disc='BD' and ano='2015' and nota<5;

#b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO
#em 2015
select mat, avg(nota) from tbl_historico where cod_disc='POO' and ano='2015';

#c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO
#em 2015 e que esta média seja superior a 6.

select mat, avg(nota) as media from tbl_historico where cod_disc='POO' and ano='2015' having media>6;

#d) Encontre quantos alunos não são de Natal.
select cidade, count(cidade) from tbl_aluno where cidade<>'Natal';


-- fim fim fim



