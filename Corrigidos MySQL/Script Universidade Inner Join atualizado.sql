use db_universidade;
select * from tbl_turma;
select * from tbl_professor;
select * from tbl_disciplina;

select tbl_turma.cod_disc, tbl_disciplina.nome_disc,
tbl_turma.cod_prof, tbl_professor.nome, tbl_turma.ano, 
tbl_turma.horario
from tbl_professor
inner join tbl_turma
on tbl_professor.cod_prof = tbl_turma.cod_prof 
inner join tbl_disciplina
on tbl_disciplina.cod_disc = tbl_turma.cod_disc
order by tbl_professor.nome asc;

select tbl_historico.mat, tbl_aluno.nome, tbl_historico.cod_disc,
tbl_disciplina.nome_disc, tbl_historico.cod_turma, tbl_historico.ano,
tbl_historico.cod_prof, tbl_professor.nome as 'Nome Professor'
from tbl_professor 
inner join tbl_historico
on tbl_professor.cod_prof=tbl_historico.cod_prof
inner join tbl_aluno
on tbl_historico.mat =tbl_aluno.mat 
inner join tbl_disciplina 
on tbl_historico.cod_disc=tbl_disciplina.cod_disc;


-- alterando a estrutura da tabela tbl_historico para que ela 
-- relacione-se com o professor diretamente
alter table tbl_historico add 
constraint fk_professor_historico foreign key (cod_prof) 
references tbl_professor (cod_prof);





















