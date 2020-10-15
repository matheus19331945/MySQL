create database db_Universidade;
use db_Universidade;

drop database db_Universidade;


create table aluno(
mat integer primary key auto_increment,
nome varchar(80)not null,
endereco varchar(80) not null,
cidade varchar(40) not null
);
alter table aluno auto_increment = 2015010101;

create table disciplina (
cod_disc varchar(3) primary key,
nome_disc varchar(80)not null,
carga_hor varchar(4) not null
);

create table professores(
cod_prof integer primary key,
nome varchar(80)not null,
endereco varchar(80) not null,
cidade varchar(40) not null
);

create table turma (
cod_disc varchar(3) not null,
cod_turma tinyint not null,
cod_prof integer not null,
ano year(4) not null,
horario varchar(7) not null,
primary key(cod_disc,cod_turma,cod_prof,ano));

create table historico(
mat integer,
cod_disc varchar(3) not null,
cod_turma tinyint not null,
cod_prof integer not null,
ano year(4) not null,
frequencia float not null,
nota float not null,
primary key(mat,cod_disc,cod_turma,cod_prof,ano));

insert into aluno 
values(2015010101,'José de Alencar','Rua das Almas','Natal'),(2015010102,'João José','Avenida Ruy Carneiro','João Pessoa'),
(2015010103,'Maria Joaquina','Rua Carrossel','Recife'),(2015010104,'Maria da Dores','Rua das Ladeiras','Fortaleza'),
(2015010105,'Josué Claudino doa Santos','Centro','João Pessoa'),(2015010106,'Josuélisson Claudino doa Santos','Centro','João Pessoa');

select * from aluno;

insert into disciplina 
values('BD','Banco de Dados','100'),('POO', 'Programação com Acesso a Banco de Dados','100'),
('WEB','Autoria Web','50'),('ENG','Engenharia de Software','80');

select * from disciplina;

insert into professores 
values(2121131,'Nickerson Ferreira','Rua Manaíra','João Pessoa'),(122135,'Adorilson Bezerra','Avenida Salgado Filho','Natal'),
(192011,'Diego Oliveira','Avenida Roberto Freire','Natal');

select * from professores;

insert into turma 
values('BD',1,2121131,2015,'11H-12H'),('BD',2,2121131,2015,'13H-14H'),
('POO',1,192011,2015,'08H-09H'),('WEB',1,'192011',2015,'07H-08H'),('ENG',1,122135,2015,'10H-11H');

select * from turma;

insert into historico 
values(2015010101,'BD',1,2121131,2015,75.25,9.5),(2015010101,'POO',2,192011,2015,45.25,4.5),(2015010101,'WEB',1,192011,2015,75.25,9.5);

select * from historico;





