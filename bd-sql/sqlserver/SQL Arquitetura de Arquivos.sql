/*Arquivos LDF e MDF
Ambos criado por padr�o

Master Data File - Armazena Dados
Ao preencher o dado de uma tabela, tamb�m � criado uma transa��o

	transa��o 

Log Data File - Armazena Log
Salva a transa��o durante o momento de sua execu��o

COMMIT - Salva o Log do LDF no MDF e ap�s apaga o Log, deixando a MDF atualizada
ROLLBACK - Apaga os dados do LDF e n�o salva nada no MDF, retornando ao ponto anterior do Banco

MDF - Dados do Sistema (Dicion�rio) **Recomendado
LDF
NDF - GP(Grupo de Dados)
		G_MKT	<-	G01 <- xyz.ndf
		G_RH	<-	G02 <- abcd.ndf
		G_VENDAS	<-	G03 <-ghi.ndf

**Al�m de separarmos logicamente, tamb�m � poss�vel separar f�sicamente os grupos
	
Organizar Fisicamente e Logicamente um Banco de Dados

1 - Criar o Banco com Arquivos para os setores de MKT e VENDAS
2 - Criar um Arquivo Geral
3 - Deixar o MDF apenas com o Dicion�rio de Dados
4 - Criar 2 grupos de arquivos (padr�o - Primary - MDF)
*/

CREATE TABLE TB_EMPRESA(
	ID INT,
	NOME VARCHAR(50)
)
GO