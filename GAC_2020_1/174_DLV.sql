SET @INI_CMP := 20190101;
SET @FIM_CMP := 20190228;
SET @AA_MM_INI := EXTRACT(YEAR_MONTH FROM @INI_CMP);
SET @AA_MM_FIM := EXTRACT(YEAR_MONTH FROM @FIM_CMP);
SET @ANO_REF:= YEAR(@INI_CMP);
SET @MES_REF:= MONTH(@FIM_CMP);


SET @ORC_CMP := (SELECT COUNT(*) FROM indicadores.DLV WHERE IS_ENGENHARIA = 0 AND DT_ASS_CTR_OGNL BETWEEN @INI_CMP AND @FIM_CMP);  

SET @RLZ_CMP := (SELECT COUNT(*) FROM indicadores.DLV WHERE IS_ENGENHARIA = 0 AND DT_ASS_CTR_OGNL BETWEEN @INI_CMP AND @FIM_CMP AND CD_ENQ_LGAL IN (163, 17));

SET @PC_RLZ_CMP := (@RLZ_CMP/ @ORC_CMP );


/** ***********************GAC01************************** */
DELETE FROM gac.DLV_GAC1;
INSERT INTO gac.DLV_GAC1

SELECT DISTINCT

1 AS cd_bloc, 
174 as cd_in, 
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND( @PC_RLZ_CMP, 4) as pc_rstd,
CASE 
	WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.9000 AND 1.0000 THEN 1.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.8000 AND 0.8999 THEN 2.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.7000 AND 0.7999 THEN 3.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.6000 AND 0.6999 THEN 4.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.5000 AND 0.5999 THEN 5.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2545 AND 0.4999 THEN 6.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2000 AND 0.2544 THEN 7.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1500 AND 0.1999 THEN 8.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1000 AND 0.1499 THEN 9.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.0000 AND 0.0999 THEN 10.0000
END AS cd_rstd,
concat('PERÃ�ODO DE APURAÃ‡ÃƒO: ', @INI_CMP, ' A ', @FIM_CMP) as tx_jst_rstd

UNION 


SELECT DISTINCT

1 AS cd_bloc, 
174 as cd_in, 
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND( @PC_RLZ_CMP, 4) as pc_rstd,
CASE 
	WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.9000 AND 1.0000 THEN 1.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.8000 AND 0.8999 THEN 2.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.7000 AND 0.7999 THEN 3.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.6000 AND 0.6999 THEN 4.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.5000 AND 0.5999 THEN 5.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2545 AND 0.4999 THEN 6.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2000 AND 0.2544 THEN 7.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1500 AND 0.1999 THEN 8.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1000 AND 0.1499 THEN 9.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.0000 AND 0.0999 THEN 10.0000
END AS cd_rstd,
concat('PERÃ�ODO DE APURAÃ‡ÃƒO: ', @INI_CMP, ' A ', @FIM_CMP) as tx_jst_rstd

UNION 

SELECT DISTINCT
1 AS cd_bloc, 
174 as cd_in, 
7419 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND((@RLZ_CMP / @ORC_CMP), 4) as pc_rstd,
CASE 
	WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.9000 AND 1.0000 THEN 1.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.8000 AND 0.8999 THEN 2.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.7000 AND 0.7999 THEN 3.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.6000 AND 0.6999 THEN 4.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.5000 AND 0.5999 THEN 5.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2545 AND 0.4999 THEN 6.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.2000 AND 0.2544 THEN 7.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1500 AND 0.1999 THEN 8.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.1000 AND 0.1499 THEN 9.0000
    WHEN ROUND((@PC_RLZ_CMP), 4) BETWEEN  0.0000 AND 0.0999 THEN 10.0000
END AS cd_rstd,
concat('PERÃ�ODO DE APURAÃ‡ÃƒO: ', @INI_CMP, ' A ', @FIM_CMP) as tx_jst_rstd;



/** ***********************GAC02************************** */
DELETE FROM gac.DLV_GAC2;
INSERT INTO gac.DLV_GAC2
SELECT DISTINCT
118 as cd_vrv,  -- QT DE CONTRATAÃ‡Ã•ES REALIZADAS POR LIMITE DE VALOR
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@RLZ_CMP as vl_vrv, 
174 as cd_in

UNION 

SELECT DISTINCT
119 as cd_crv,  -- QT TOTAL DE CONTRATAÃ‡OES
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ORC_CMP as vl_vrv, 
174 as cd_in

UNION 


SELECT DISTINCT
118 as cd_vrv,  -- QT DE CONTRATAÃ‡Ã•ES REALIZADAS POR LIMITE DE VALOR
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@RLZ_CMP as vl_vrv, 
174 as cd_in

UNION 

SELECT DISTINCT
119 as cd_crv,  -- QT TOTAL DE CONTRATAÃ‡OES
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ORC_CMP as vl_vrv, 
174 as cd_in

UNION 

SELECT DISTINCT
118 as cd_vrv, -- QT DE CONTRATAÃ‡Ã•ES REALIZADAS POR LIMITE DE VALOR
7419 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@RLZ_CMP as vl_vrv, 
174 as cd_in

UNION 

SELECT DISTINCT
119 as cd_crv,  -- QT TOTAL DE CONTRATAÃ‡OES
7419 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ORC_CMP as vl_vrv, 
174 as cd_in;



/** ***********************GAC03************************** */
DELETE FROM gac.DLV_GAC3;
INSERT INTO gac.DLV_GAC3
SELECT DISTINCT
    23 AS cd_evt,
    174 AS cd_in,
    2 AS qlc_evt,
    7419 AS cd_prf_depe,
    CTR AS nr_doc,
    @ANO_REF AS ano_ref,
    @MES_REF AS mes_ref,
    DATEDIFF(CURDATE(), 19600101) AS dt_prct
FROM
   indicadores.DLV 
   WHERE IS_ENGENHARIA = 0 AND DT_ASS_CTR_OGNL BETWEEN @INI_CMP AND @FIM_CMP AND CD_ENQ_LGAL IN (163, 17);



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
	",'",
	tx_jst_rstd,
	"')"
FROM 
	gac.DLV_GAC1;


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
FROM gac.DLV_GAC2;


SELECT
	'VALUES(',
	cd_evt,
	',',
	cd_in,
	',',
	qlc_evt,
	',',
	cd_prf_depe,
	",'",
	nr_doc,
	"',",
	ano_ref,
	',',
	mes_ref,
	',',
	dt_prct,
	')'
FROM gac.DLV_GAC3;


