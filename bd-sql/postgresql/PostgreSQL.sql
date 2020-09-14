/* FUNÇÕES DE AGREGAÇÃO */

/*query simples*/

select * from funcionarios;

/*contando o numero de ocorrencias*/
--BI e DataScience trabalham com agregação

select count(*) from funcionarios;
select count(*) from departamentos;
select count(*) from localizacao;

/*Agrupando por sexo com o group by*/

select sexo, count(*) as "Quantidade" from funcionarios
group by sexo;

/*Mostrando o numero de funcionários em cada departamento*/
select departamento, count(*) as quantidade from funcionarios
group by departamento;


/*Exibindo o máximo de salários*/
select max(salario) as "Salario máximo" from funcionarios;

/*Exibindo o mínimo de salários*/
select min(salario) as "Salario mínimo" from funcionarios;

/*Exibindo o mínimo e máximo de salários juntos*/
select min(salario) as "Salario mínimo", max(salario) as "Salário máximo" from funcionarios;

/*Exibindo o mínimo e máximo de salários de cada departamento*/
select departamento, min(salario) as "Salario mínimo", max(salario) as "Salário máximo" from funcionarios
group by departamento;

/*Exibindo o mínimo e máximo de salários por sexo*/
select sexo, min(salario) as "Salario mínimo", max(salario) as "Salário máximo" from funcionarios
group by sexo;

/*Estatísticas*/

/*Mostrando uma quantidade limitada de linhas*/
select * from funcionarios
limit 10;

/*Qual o gasto total de salario pago pela empresa?*/
select sum(salario) from funcionarios;

/*Qual o motante total que acada departamento recebe de salario*/
select departamento, sum(salario) from funcionarios
group by departamento;

/*Por departamento, qual o total e a média paga para os funcionários?*/
select departamento, sum(salario), avg(salario) from funcionarios
group by departamento;

/*ordenando*/
select departamento, sum(salario), avg(salario) from funcionarios
group by departamento
order by 3;

select departamento, sum(salario), avg(salario) from funcionarios
group by departamento
order by 3 ASC;

select departamento, sum(salario), avg(salario) from funcionarios
group by departamento
order by 3 DESC;

--A MÉDIA É MUITO SENSÍVEL A OUTLIER
--PARA DESCREVER UM CONJUNTO DE DADOS É PRECISO ANALISAR TODAS AS MEDIDAS
--SOMA, MAX, MIN, MÉDIA, MEDIANA, MODA, AMPLITUDE, VARIÂNCIA, DESVIO PADRÃO, COEF.VAR

/* Modelagem Banco de Dados x Data Science*/

/*Banco de dados -> 1,2 e 3 formas normais
evitam redundancia, consequentemente poupam espaço em disco.
Consomem muito processamento em função de Joins. Queries lentas*/

/*Data Science e B.I -> Focam em agregações e performance.
Não se preocupam com espaço em disco. Em B.I, modelagem mínima
em Data Science, preferencialmente modelagem Colunar*/

/*Importanto CSV*/

--Criando tabela para atender o CSV

CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
	DIA INT,
	QTD NUMERIC(10,2)
);

COPY MAQUINAS
FROM 'C:\Users\felip\Desktop\LogMaquinas.csv'
DELIMITER ','
CSV HEADER;

select * from maquinas;

/*Qual a media de cada maquina*/
select MAQUINA, AVG(QTD) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

--Arredondado
select MAQUINA, ROUND(AVG(QTD),2) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

/*Qual a moda das quantidades*/

select maquina, qtd, count(*)
from maquinas
group by maquina, qtd
order by 3 desc;

/*Qual a moda das quantidades de cada maquina*/
select maquina, qtd, count(*) from maquinas
where maquina ='Maquina 01'
group by maquina, qtd
order by 3 desc
limit 1; --trouxe a primeira moda que encontrou

select maquina, qtd, count(*) from maquinas
where maquina ='Maquina 02'
group by maquina, qtd
order by 3 desc
limit 1;

select maquina, qtd, count(*) from maquinas
where maquina ='Maquina 03'
group by maquina, qtd
order by 3 desc
limit 1;

/*MODA DO DATASET INTEIRO*/
--Histograma
select qtd, count(*) from maquinas
group by qtd
order by 2 desc;

select qtd, count(*) from maquinas
group by qtd
order by 2 desc
limit 1;

/*QUAL O MÁXIMO E MÍNIMO, MEDIA E AMPLITUDE DE CADA MÁQUINA*/

SELECT MAQUINA, 
	ROUND(AVG(QTD),2) AS MEDIA,
	MAX(QTD) AS MAXIMO,
	MIN(QTD) AS MINIMO,
	MAX(QTD) - MIN(QTD) AS AMPLITUDE
FROM MAQUINAS
	GROUP BY MAQUINA
	ORDER BY 4 DESC;
	
/*DESVIDO PADRÃO E VARIANCIA*/
--STDDEV_POP(COLUNA)
--VAR_POP(COLUNA)

SELECT MAQUINA, 
	ROUND(AVG(QTD),2) AS MEDIA,
	MAX(QTD) AS MAXIMO,
	MIN(QTD) AS MINIMO,
	MAX(QTD) - MIN(QTD) AS AMPLITUDE,
	ROUND(STDDEV_POP(QTD),2) AS DESV_PAD,
	ROUND(VAR_POP(QTD),2) AS VARIANCIA
FROM MAQUINAS
	GROUP BY MAQUINA
	ORDER BY 4 DESC;

/*CRIANDO FUNÇÃO DE MEDIANA*/

CREATE OR REPLACE FUNCTION _final_median(NUMERIC[])
   RETURNS NUMERIC AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;
									 
CREATE AGGREGATE median(NUMERIC) (
  SFUNC=array_append,
  STYPE=NUMERIC[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS;

SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01';

SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02';

SELECT ROUND(MEDIAN(QTD),2) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03';

/* QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE TOTAL
	VARIANCIA
	DESVIO PADRÃO
	MEDIANA
	COEFICIENTE DE VARIAÇÃO
*/

SELECT MAQUINA, 
	COUNT(QTD) AS "QUANTIDADE",
	SUM(QTD) AS "TOTAL",
	ROUND(AVG(QTD),2) AS "MEDIA",
	MAX(QTD) AS "MAXIMO",
	MIN(QTD) AS "MINIMO",
	MAX(QTD) - MIN(QTD) AS "AMPLITUDE TOTAL",
	ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
	ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	ROUND((STDDEV_POP(QTD)/AVG(QTD))*100,2) AS "COEFICIENTE DE VARIACAO"
	FROM MAQUINAS
	GROUP BY MAQUINA
	ORDER BY 1;
	
/*MODA - MODE() WITHING ROUP(ORDER BY COLUNA)*/

SELECT MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" FROM MAQUINAS; -- TROUXE A MODA DE TODA A COLUNA QTD

SELECT MAQUINA, MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" 
FROM MAQUINAS
GROUP BY MAQUINA;

SELECT MAQUINA, 
	COUNT(QTD) AS "QUANTIDADE",
	SUM(QTD) AS "TOTAL",
	ROUND(AVG(QTD),2) AS "MEDIA",
	MAX(QTD) AS "MAXIMO",
	MIN(QTD) AS "MINIMO",
	MAX(QTD) - MIN(QTD) AS "AMPLITUDE TOTAL",
	ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
	ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	ROUND((STDDEV_POP(QTD)/AVG(QTD))*100,2) AS "COEFICIENTE DE VARIACAO",
	MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" 
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 1;

/*Exportando em Formato Colunar*/

/*Podemos criar uma tabela com o resultado de uma querie
e essa é a forma de realizar uma modelagem colunar 
CREATE TABLE AS SELECT
*/

SELECT F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA AS DATA , L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

CREATE TABLE MY_REL_LOCADORA AS
SELECT F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA AS DATA , L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

SELECT * FROM MY_REL_LOCADORA;

--Copy from cria uma tabela copiando os dados de um csv, copy to cria um csv copiando os dados de uma tabela
COPY MY_REL_LOCADORA TO
'C:\Users\felip\Desktop\MY_REL_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

--BD RELACIONAL (INSERT - DELETE - UPDATE)
--DATA WAREHOUSE CONSULTAS E QUERIES PESADAS


/*SINCRONIZANDO TABELAS E RELATÓRIOS*/

DROP TABLE LOCACAO;

CREATE SEQUENCE SEQ_LOCACAO;

--NEXTVAL('SEQ_LOCACAO');

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/08/2018',23,3,100);

SELECT * FROM LOCACAO;

SELECT * FROM MY_REL_LOCADORA;
DROP table MY_REL_LOCADORA;

SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

CREATE TABLE MY_RELATORIO_LOCADORA AS
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

SELECT * FROM MY_RELATORIO_LOCADORA;
SELECT * FROM LOCACAO;

/*SELECT PARA TRAZER OS REGISTROS NOVOS*/

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM MY_RELATORIO_LOCADORA;

SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME
WHERE IDLOCACAO NOT IN(SELECT IDLOCACAO FROM MY_RELATORIO_LOCADORA);

/*INSERINDO OS REGISTROS NOVOS*/
INSERT INTO MY_RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME
WHERE IDLOCACAO NOT IN(SELECT IDLOCACAO FROM MY_RELATORIO_LOCADORA);

/*VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMÁTICO POR MEIO DE UMA TRIGGER*/

--POSTGRE FUNÇÃO CHAMA UMA TRIGGER


--Criando function
CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

INSERT INTO MY_RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME
WHERE IDLOCACAO NOT IN(SELECT IDLOCACAO FROM MY_RELATORIO_LOCADORA);

COPY MY_RELATORIO_LOCADORA TO
'C:\Users\felip\Desktop\MY_RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

/*Comando para apagar uma trigger*/

drop trigger tg_relatorio on locacao;

create trigger tg_relatorio
after insert on locacao
for each row
	execute procedure atualiza_rel();
	
/*inserindo novos registros*/

insert into locacao values(nextval('SEQ_LOCACAO'), NOW(), 100,7,300);
insert into locacao values(nextval('SEQ_LOCACAO'), NOW(), 500,1,200);
insert into locacao values(nextval('SEQ_LOCACAO'), NOW(), 800,6,500);
nto locacao values



SELECT * FROM LOCACAO;
SELECT * FROM MY_RELATORIO_LOCADORA;

/*sincronizando com registros deletados*/

CREATE OR REPLACE FUNCTION DELETE_LOCACAO()
RETURNS TRIGGER AS
$$
BEGIN

DELETE FROM MY_RELATORIO_LOCADORA
WHERE IDLOCACAO = OLD.IDLOCACAO;

COPY MY_RELATORIO_LOCADORA TO
'C:\Users\felip\Desktop\MY_RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN OLD;
END;
$$
LANGUAGE PLPGSQL;


CREATE TRIGGER TR_DELETE_REG
	BEFORE DELETE ON LOCACAO
	FOR EACH ROW
	EXECUTE PROCEDURE DELETE_LOCACAO();
	
	
SELECT * FROM LOCACAO;
SELECT * FROM MY_RELATORIO_LOCADORA;

DELETE FROM LOCACAO
WHERE IDLOCACAO =1;

/*Qual a moda dos salarios. A moda dos salários diz algo de relevante?*/
select salario, count(salario) as ocorrencias from funcionarios
group by salario
order by 2 desc;

SELECT MODE() WITHIN GROUP(ORDER BY SALARIO) AS "MODA" 
FROM FUNCIONARIOS;

/*Qual a moda departamental = qual departamento que mais emprega?*/
select departamento, count(departamento) as ocorrencias
from funcionarios
group by departamento
order by 2 desc
;

SELECT MODE() WITHIN GROUP(ORDER BY DEPARTAMENTO) AS "MODA" 
FROM FUNCIONARIOS;

/*Qual o desvio padrão de cada departamento?*/
select departamento, ROUND(STDDEV_POP(SALARIO),2) AS "DESVIO PADRAO"
from funcionarios
GROUP BY DEPARTAMENTO;

/*Calcule a mediana salarial de todo o set de dados*/
SELECT ROUND(MEDIAN(SALARIO),2) AS "MEDIANA"
FROM FUNCIONARIOS;

/*Qual amplitude de todos os salários?*/

SELECT MAX(SALARIO) - MIN(SALARIO) AS "AMPLITUDE TOTAL"
FROM FUNCIONARIOS;

/*Calcule as principais medidas estatísticas pro departamento*/
SELECT MAQUINA, 
	COUNT(QTD) AS "QUANTIDADE",
	SUM(QTD) AS "TOTAL",
	ROUND(AVG(QTD),2) AS "MEDIA",
	MAX(QTD) AS "MAXIMO",
	MIN(QTD) AS "MINIMO",
	MAX(QTD) - MIN(QTD) AS "AMPLITUDE TOTAL",
	ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
	ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	ROUND((STDDEV_POP(QTD)/AVG(QTD))*100,2) AS "COEFICIENTE DE VARIACAO",
	MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" 
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 1;

SELECT DEPARTAMENTO,
	COUNT(DEPARTAMENTO) AS FUNCIONARIOS,
	SUM(SALARIO) AS "SALARIO TOTAL",
	ROUND(AVG(SALARIO),2) AS "MEDIA SALARIAL",
	MAX(SALARIO) AS "SALARIO MAXIMO",
	MIN(SALARIO) AS "SALARIO MINIMO",
	MAX(SALARIO) - MIN(SALARIO) AS "AMPLITUDE SALARIAL",
	ROUND(VAR_POP(SALARIO), 2) AS "VARIANCIA SALARIAL",
	ROUND(STDDEV_POP(SALARIO),2) AS "DESVIO SALARIAL PADRAO",
	ROUND(MEDIAN(SALARIO), 2) AS "MEDIANA SALARIAL",
	ROUND((STDDEV_POP(SALARIO)/AVG(SALARIO))*100,2) AS "COEFICIENTE DE VARIACAO",
	MODE() WITHIN GROUP(ORDER BY SALARIO) AS "MODA" 
	from funcionarios
	group by departamento;
/*Qual departamento te dá uma maior probabilidade de ganhar mais? --Outdoor */

--VARIÁVEIS DUMMY PARA MACHINE LEARNING

/*Utilizando o case*/

select nome, sexo from funcionarios;

select cargo,
case
	when cargo = 'Finacial Advisor' then 'condicao 01'
	when cargo = 'Sctructural Engineer' then 'condicao 02'
	when cargo = 'Executive Secretary' then 'condicao 03'
	when cargo = 'Sales Associative' then 'condicao 04'
	else 'sem condição irmão'
end as "condicoes"
	from funcionarios
group by 1;


/*utilizando valores booleanos*/

select nome, cargo, (sexo = 'Masculino') AS Masculino, (sexo = 'Feminino') AS Masculino  from funcionarios;

/*meclando as tecnicas*/

select nome, cargo,
case
	when (sexo='Masculino') = true then 1
	else 0
end as "MASCULINO",
case
	when (sexo='Feminino') = true then 1
	else 0
end as "FEMININO"
FROM FUNCIONARIOS;

/*Filtros de Grupo*/

/*FILTROS BASEADOS EM VALORES NUMERICOS*/

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

SELECT NOME, DEPARTAMENTO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

/*FILTROS BASEADOS EM STRINGS*/

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'; --Case Sensitive em String

/*FILTROS BASEADOS EM MULTIPLAS COLUNAS E MULTIPLOS TIPOS*/

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas' AND
SALARIO >100000;

/*FILTROS BASEADOS EM UM UNICO TIPO E COLUNA*/
SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
AND
DEPARTAMENTO = 'Books'; --Na nossa modelagem isso nunca será verdadeiro

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
OR
DEPARTAMENTO = 'Books';

--em relacionamentos 1x1 o filtro and tratando de uma unica coluna sempre será falso

/*FILTROS BASEADOS EM PADRÃO DE CARACTERES*/
SELECT DEPARTAMENTO, sum(SALARIO) as TOTAL
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO;

SELECT DEPARTAMENTO, sum(SALARIO) as TOTAL
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'Bo%'
GROUP BY DEPARTAMENTO;

SELECT DEPARTAMENTO, sum(SALARIO) as TOTAL
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%s'
GROUP BY DEPARTAMENTO;

/*se eu quisesse filtrar o agrupamento pelo salario?
por exemplo, maior que 4.000.000*/
--colunas não agregadas where, colunas agregadas having

SELECT DEPARTAMENTO, sum(SALARIO) as TOTAL
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO
having sum(SALARIO) > 4000000;


/*MULTILOS CONTADORES*/
SELECT COUNT(*) FROM FUNCIONARIOS;
SELECT COUNT(*) AS "QUANTIDADE TOTAL" FROM FUNCIONARIOS;

SELECT SEXO, COUNT(*) --querie que conta a quantidade do sexo masculino
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
group by sexo;

select count(*) as "QUANTIDADE TOTAL", 
COUNT(SELECT COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
group by sexo) AS "FUNCIONARIOS HOMENS"
FROM FUNCIONARIOS;

select count(*) as "QUANTIDADE TOTAL", --FUNCIONA MAS SUBQUERIE DEGRADA PERFORMANCE
(SELECT COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
group by sexo)AS "FUNCIONARIOS HOMENS"
FROM FUNCIONARIOS;

--Forma Facil

SELECT COUNT(*) AS "QUANTIDADE TOTAL",
COUNT(*) FILTER(WHERE SEXO = 'Masculino') AS "FUNCIONARIOS",
COUNT(*) FILTER(WHERE SEXO = 'Feminino') AS "FUNCIONARIAS",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books') AS "FUNCIONARIOS GERAL BOOKS",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books' AND SALARIO > 100000) AS "FUNCIONARIOS GERAL BOOKS COM ALTO SALARIO",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books' AND SALARIO > 100000 AND SEXO = 'Feminino') AS "FUNCIONARIAS BOOKS COM ALTO SALARIO",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books' and sexo = 'Masculino') as "FUNCIONARIOS BOOKS",
COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books' and sexo = 'Feminino') as "FUNCIONARIAS BOOKS"
FROM FUNCIONARIOS;

/*Reformatando Strings*/
/*listando*/

select departamento from funcionarios;

/*distinct*/
select distinct departamento from funcionarios;

/*uppercase*/

select distinct upper(departamento) from funcionarios;

/*lowercase*/

select distinct lower(departamento) from funcionarios;

/*concatenando strings*/
select cargo || ' - ' || departamento
from funcionarios;

select upper(cargo || ' - ' || departamento) as "Cargo completo Upper",
lower(cargo || ' - ' || departamento) as "Cargo completo Lower"
from funcionarios;

/*Remover espacos*/

select '      UNIDADOS      ';

/*Contando caracteres*/
select length('      UNIDADOS      ');
select length('      UNIDADOS     a ');

select trim('      UNIDADOS      ');
select trim('      UNIDADOS     a ');

trim('      UNIDADOS     a ');
trim('      UNIDADOS      ');

select length(trim('      UNIDADOS     a '));
select length(trim('      UNIDADOS      '));


/*DESAFIO - CRIAR UMA COLUNA AO LADO DA COLUNA CARGO, QUE DIGA SE A PESSOA É ASSISTENTE OU NÃO Assistant*/

SELECT NOME, CARGO, (CARGO LIKE '%Assistant%') as "É ASSISTENTE?",
case
	when (CARGO LIKE '%Assistant%') = true then 1
	else 0
end as "DUMMY É ASSISTENTE?"
from funcionarios;