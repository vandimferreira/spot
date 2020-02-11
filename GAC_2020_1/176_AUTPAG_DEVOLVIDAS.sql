SET @INI_CMP := 20200101;
SET @FIM_CMP := 20200131;
SET @AA_MM_INI := EXTRACT(YEAR_MONTH FROM @INI_CMP);
SET @AA_MM_FIM := EXTRACT(YEAR_MONTH FROM @FIM_CMP);
SET @ANO_REF:= YEAR(@INI_CMP);
SET @MES_REF:= MONTH(@FIM_CMP);


SET @QT_TOTAL := (SELECT COUNT(*) FROM (SELECT  DISTINCT AUTPAG, DT_SITUACAO, HORA_SITUACAO FROM spfGestaoAutpags.autpags WHERE DT_SITUACAO BETWEEN @INI_CMP AND @FIM_CMP) B);
SET @QT_REALZ  := (SELECT COUNT(*) FROM (SELECT  DISTINCT AUTPAG, DT_SITUACAO, HORA_SITUACAO FROM spfGestaoAutpags.autpags WHERE DT_SITUACAO BETWEEN @INI_CMP AND @FIM_CMP AND SITUACAO ='DEVOLVIDA') A);
SET @PC_REALZ := ((@QT_REALZ/ @QT_TOTAL));


/** ***********************GAC01************************** */


DROP TABLE IF EXISTS spfGestaoAutpags.GAC_1;
DROP TABLE IF EXISTS spfGestaoAutpags.GAC_2;
DROP TABLE IF EXISTS spfGestaoAutpags.GAC_3;


CREATE TEMPORARY TABLE spfGestaoAutpags.GAC_1 AS 


SELECT DISTINCT
1 AS cd_bloc, 
176 as cd_in, 
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND(@PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7001 AND 1.0000 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.5001 AND 0.7000 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.4001 AND 0.5000 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3001 AND 0.4000 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.2001 AND 0.3000 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0801 AND 0.2000 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0501 AND 0.0800 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0301 AND 0.0500 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0101 AND 0.0300 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.0100 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd

UNION

SELECT DISTINCT
1 AS cd_bloc, 
176 as cd_in, 
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND(@PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7001 AND 1.0000 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.5001 AND 0.7000 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.4001 AND 0.5000 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3001 AND 0.4000 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.2001 AND 0.3000 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0801 AND 0.2000 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0501 AND 0.0800 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0301 AND 0.0500 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0101 AND 0.0300 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.0100 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd

UNION 

SELECT DISTINCT
1 AS cd_bloc, 
176 as cd_in, 
7417 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND( @PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7001 AND 1.0000 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.5001 AND 0.7000 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.4001 AND 0.5000 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3001 AND 0.4000 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.2001 AND 0.3000 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0801 AND 0.2000 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0501 AND 0.0800 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0301 AND 0.0500 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0101 AND 0.0300 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.0100 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd;



/** ***********************GAC02************************** */

CREATE TEMPORARY TABLE spfGestaoAutpags.GAC_2 AS 

SELECT DISTINCT
122 as cd_vrv,  -- QT AUTPAGS DEVOLVIDAS
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_REALZ as vl_vrv, 
176 as cd_in

UNION 

SELECT DISTINCT
123 as cd_crv, -- QT AUTPGAS PROTOCOLADAS
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_TOTAL as vl_vrv, 
176 as cd_in

UNION 

SELECT DISTINCT
122 as cd_vrv,  -- QT AUTPAGS DEVOLVIDAS
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_REALZ as vl_vrv, 
176 as cd_in

UNION 

SELECT DISTINCT
123 as cd_crv, -- QT AUTPGAS PROTOCOLADAS
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_TOTAL as vl_vrv, 
176 as cd_in

UNION 

SELECT DISTINCT
122 as cd_vrv, -- QT AUTPAGS DEVOLVIDAS
7417 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_REALZ as vl_vrv, 
176 as cd_in

UNION 

SELECT DISTINCT
123 as cd_crv,   -- QT AUTPAGS PROTOCOLADAS
7417 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@QT_TOTAL as vl_vrv, 
176 as cd_in;

/** ***********************GAC03************************** */

CREATE TEMPORARY TABLE spfGestaoAutpags.GAC_3 AS 

SELECT DISTINCT
23 as cd_evt, 
176 as cd_in, 
2 as qlc_evt, 
7417 as cd_prf_depe,
quote(CONCAT(AUTPAG, ' ', IFNULL(DT_SITUACAO, ''), ' ', IFNULL(HORA_SITUACAO, ''))) as nr_doc, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE() , 19600101) as dt_prct


FROM spfGestaoAutpags.autpags

WHERE SITUACAO ='DEVOLVIDA'
AND DT_SITUACAO BETWEEN @INI_CMP AND @FIM_CMP
ORDER BY AUTPAG;




SELECT 
	'VALUES(',
    cd_bloc, 
    ',',
    cd_in, 
    ',',
    cd_prf_depe, 
    ',',
    ano_ref,
    ',',
    mes_ref,
    ',',
    dt_prct,
    ',', 
    pc_rstd,
    ',',
    cd_rstd,
    ',',
    tx_jst_rstd,
    ')'
 FROM 
	spfGestaoAutpags.GAC_1
    ;
    
SELECT
	'VALUES(',
	cd_vrv,
    ',',
    cd_prf_depe, 
    ',',
    ano_ref, 
    ',',
    mes_ref, 
    ',',
    vl_vrv, 
    ',',
    cd_in,
    ')'    
FROM 
	spfGestaoAutpags.GAC_2
    ;
    
    
    
SELECT 
	'VALUES(',
    cd_evt,
    ',',
    cd_in,
    ',',
    qlc_evt,
    ',',
    cd_prf_depe,
    ',',
    nr_doc,
    ',',
    ano_ref,
    ',',
    mes_ref,
    ',',
    dt_prct,
    ')'
FROM 
	spfGestaoAutpags.GAC_3
    ;