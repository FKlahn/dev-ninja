/*TSQL � UM BLOCO DE LINGUAGEM DE PROGRAMA��O
PODENDO SER AN�NIMO OU N�O
BLOCOS ANONIMOS N�O RECEBEM NOME, POIS N�O S�O SALVOS NO BANCO.
CRIAMOS BLOCOS AN�NIMOS QUANDO IREMOS EXECUT�-LOS UMA S� VEZ OU TESTAR ALGO*/

--BLOCO DE EXECU��O
BEGIN
	PRINT 'PRIMEIRO BLOCO'
END
GO

--BLOCOS DE ATRIBUI��O DE VARI�VEIS

DECLARE
	@CONTADOR INT
BEGIN
	SET @CONTADOR = 5
	PRINT @CONTADOR
END
GO

SELECT @ CONTADOR

--A variavel contador est� delimitada pelo go

/*NO SQL SERVER CADA COLUNA VARIAVEL LOCAL EXPRESS�O E PARAMETRO TEM UM TIPO*/

DECLARE
	
	@V_NUMERO NUMERIC(10,2) = 100.52,
	@V_DATA DATETIME = '20170207'

BEGIN
	PRINT 'VALOR NUMERICO: ' + CAST(@V_NUMERO AS VARCHAR)
	PRINT 'VALOR NUMERICO: ' + CONVERT(VARCHAR, @V_NUMERO)
	PRINT 'VALOR DE DATA: ' + CAST(@V_DATA AS VARCHAR)
	PRINT 'VALOR DE DATA: ' + CONVERT(VARCHAR, @V_DATA, 121)
	PRINT 'VALOR DE DATA: ' + CONVERT(VARCHAR, @V_DATA, 120)
	PRINT 'VALOR DE DATA: ' + CONVERT(VARCHAR, @V_DATA, 105)

END
GO

--CONVERT � MAIS UTILIZADO PARA DATAS E CAST � UTILIZADO NORMALMENTE PARA OS DEMAIS TIPOS

/* ATRIBUINDO RESULTADOS A UMA VARIAVEL */

CREATE TABLE CARROS(
	CARRO VARCHAR(20),
	FABRICANTE VARCHAR(30)
)
GO

INSERT INTO CARROS VALUES('KA','FORD')
INSERT INTO CARROS VALUES('FIESTA','FORD')
INSERT INTO CARROS VALUES('PRISMA','FORD')
INSERT INTO CARROS VALUES('CLIO','RENAULT')
INSERT INTO CARROS VALUES('SANDERO','RENAULT')
INSERT INTO CARROS VALUES('CHEVETE','CHEVROLET')
INSERT INTO CARROS VALUES('OMEGA','CHEVROLET')
INSERT INTO CARROS VALUES('PALIO','FIAT')
INSERT INTO CARROS VALUES('DOBLO','FIAT')
INSERT INTO CARROS VALUES('UNO','FIAT')
INSERT INTO CARROS VALUES('GOL','VOLKSWAGEN')
GO

DECLARE
	@V_CONT_FORD INT,
	@V_CONT_FIAT INT
BEGIN
	--M�TODO 1 - O SELECT PRECISA RETORNAR UMA SIMPLES COLUNA E UM S� RESULTADO
	SET @V_CONT_FORD = (SELECT COUNT(*) FROM CARROS WHERE FABRICANTE ='FORD')
	PRINT 'QUANTIDADE FORD: ' + CAST(@V_CONT_FORD AS VARCHAR)

	--M�TODO 2
	SELECT @V_CONT_FIAT = COUNT(*) FROM CARROS WHERE FABRICANTE = 'FIAT'

	PRINT 'QUANTIDADE FIAT: ' + CONVERT(VARCHAR, @V_CONT_FIAT)
END
GO

/*BLOCOS IF E ELSE*/

DECLARE
	@NUMERO INT = 5
BEGIN
	IF @NUMERO = 5 --EXPRESS�O BOOLEANA - V OU F
		PRINT 'O VALOR � VERDADEIRO'
	ELSE
		PRINT 'O VALOR � FALSO'
END
GO

/*CASE*/

DECLARE
	@CONTADOR INT

BEGIN
	SELECT --O CASE REPRESENTA UMA COLUNA
	CASE --N�O � EXATAMENTE UMA CLAUSULA DE PROGRAMA��O
		WHEN FABRICANTE = 'FIAT' THEN 'FAIXA 1'
		WHEN FABRICANTE = 'CHEVROLET' THEN 'FAIXA 2'
		ELSE 'OUTRAS FAIXAS'
	END AS 'INFORMA��ES',
	*
	FROM CARROS
END
GO

/*BLOCO NOMEADO - PROCEDURES*/

CREATE PROC VERIFICANUMERO @NUMERO INT
AS

	IF @NUMERO = 5 --EXPRESS�O BOOLEANA - V OU F
		PRINT 'O VALOR � VERDADEIRO'
	ELSE
		PRINT 'O VALOR � FALSO'
GO

EXEC VERIFICANUMERO 5
GO
EXEC VERIFICANUMERO 7
GO

/*LOOPS WHILE*/

DECLARE
	@I INT = 1

BEGIN
	WHILE (@I<15)
	BEGIN
		PRINT 'VALOR DE @I: ' + CAST(@I AS VARCHAR)
		SET @I = @I +1
	END
END
GO