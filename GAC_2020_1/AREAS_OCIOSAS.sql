SET @INI_CMP := 20190101;
SET @FIM_CMP := 20190531;
SET @AA_MM_INI := EXTRACT(YEAR_MONTH FROM @INI_CMP);
SET @AA_MM_FIM := EXTRACT(YEAR_MONTH FROM @FIM_CMP);
SET @ANO_REF:= YEAR(@INI_CMP);
SET @MES_REF:= MONTH(@FIM_CMP);

SET @QT_TOTAL := (SELECT COUNT(A.nr_unvl_bem)  FROM
					(SELECT DISTINCT a.nr_unvl_bem, a.nr_unvl_trrn, b.nr_adar_lcl,
						CASE WHEN b.cd_res_ocpt LIKE 'OD' THEN 'OCIOSA DESOCUPADA' WHEN b.cd_res_ocpt LIKE 'OL' THEN 'OCIOSA LOCADA' WHEN b.cd_res_ocpt LIKE 'OC' THEN 'OCIOSA CEDIDA' ELSE 'OUTROS' END AS nm_res_ocpt,
						CASE WHEN cd_fma_aqs_bem IN (2, 12) THEN 'TERCEIROS' ELSE 'PRÓPRIO' END AS tip_imv,
						f.dt_fim_ctr,CASE WHEN f.dt_fim_ctr IS NULL THEN 'N/D' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) < 0 THEN 'VENCIDO' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) BETWEEN 0 AND 180 THEN 'A VENCER ATÉ 6 MESES' ELSE 'A VENCER APÓS 6 MESES' END AS nm_tip_fxa_vnct_ctr
						FROM crm.NIMV_UTZO a
						INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
						LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
						WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL)) A);


SET @QT_REALZ  := (SELECT COUNT(A.nr_unvl_bem) FROM
						(SELECT DISTINCT a.nr_unvl_bem, a.nr_unvl_trrn, b.nr_adar_lcl,
							CASE WHEN b.cd_res_ocpt LIKE 'OD' THEN 'OCIOSA DESOCUPADA' WHEN b.cd_res_ocpt LIKE 'OL' THEN 'OCIOSA LOCADA' WHEN b.cd_res_ocpt LIKE 'OC' THEN 'OCIOSA CEDIDA' ELSE 'OUTROS' END AS nm_res_ocpt,
							CASE WHEN cd_fma_aqs_bem IN (2, 12) THEN 'TERCEIROS' ELSE 'PRÓPRIO' END AS tip_imv,
							f.dt_fim_ctr, CASE WHEN f.dt_fim_ctr IS NULL THEN 'N/D' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) < 0 THEN 'VENCIDO' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) BETWEEN 0 AND 180 THEN 'A VENCER ATÉ 6 MESES' ELSE 'A VENCER APÓS 6 MESES' END AS nm_tip_fxa_vnct_ctr
							FROM crm.NIMV_UTZO a
							INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
							LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
							WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL ) AND NOT f.dt_fim_ctr IS NULL AND DATEDIFF(f.dt_fim_ctr,CURDATE()) > 0) A);

SET @ORC :=  (@QT_TOTAL * 0.95);	
					
SET @PC_REALZ := ((@QT_REALZ/ @ORC));

SET @AVENCERATE6MESES := (SELECT DISTINCT COUNT(*) FROM crm.NIMV_UTZO a
							INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
							LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
							WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL) AND DATEDIFF(f.dt_fim_ctr,CURDATE()) BETWEEN 0 AND 180);

SET @AVENCERAPOS6MESES := (SELECT DISTINCT COUNT(*) FROM crm.NIMV_UTZO a
							INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
							LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
							WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL) AND DATEDIFF(f.dt_fim_ctr,CURDATE()) > 180);

SET @VENCIDO := (SELECT DISTINCT COUNT(*) FROM crm.NIMV_UTZO a
							INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
							LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
							WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL) AND DATEDIFF(f.dt_fim_ctr,CURDATE()) < 0);


SET @ND := (SELECT DISTINCT COUNT(*) FROM crm.NIMV_UTZO a
							INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
							LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
							WHERE a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))) and b.CD_RES_OCPT IN ('OC', 'OD', 'OL') and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL) AND f.dt_fim_ctr IS NULL);

SELECT @QT_TOTAL, @ORC, @QT_REALZ, @PC_REALZ;

DROP TABLE IF EXISTS gac.AREAS_OCIOSAS_GAC1;
CREATE TABLE gac.AREAS_OCIOSAS_GAC1

SELECT DISTINCT
1 AS cd_bloc, 
184 as cd_in, 
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND(@PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.2999 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3000 AND 0.5999 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.6000 AND 0.6999 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7000 AND 0.7999 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.8000 AND 0.8999 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9000 AND 0.9599 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9600 AND 0.9699 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9700 AND 0.9849 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9850 AND 0.9949 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9950 AND 1.0000 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd

UNION 

SELECT DISTINCT
1 AS cd_bloc, 
184 as cd_in, 
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND(@PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.2999 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3000 AND 0.5999 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.6000 AND 0.6999 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7000 AND 0.7999 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.8000 AND 0.8999 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9000 AND 0.9599 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9600 AND 0.9699 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9700 AND 0.9849 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9850 AND 0.9949 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9950 AND 1.0000 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd

UNION

SELECT DISTINCT
1 AS cd_bloc, 
184 as cd_in, 
9101 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE(), 19600101) as dt_prct,
ROUND(@PC_REALZ, 4) as pc_rstd,
CASE 
	WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.0000 AND 0.2999 THEN 1.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.3000 AND 0.5999 THEN 2.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.6000 AND 0.6999 THEN 3.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.7000 AND 0.7999 THEN 4.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.8000 AND 0.8999 THEN 5.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9000 AND 0.9599 THEN 6.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9600 AND 0.9699 THEN 7.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9700 AND 0.9849 THEN 8.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9850 AND 0.9949 THEN 9.0000
    WHEN ROUND(@PC_REALZ, 4) BETWEEN  0.9950 AND 1.0000 THEN 10.0000
END AS cd_rstd,
QUOTE(concat('PERÍODO DE APURAÇÃO: ', @INI_CMP, ' A ', @FIM_CMP)) as tx_jst_rstd;


DROP TABLE IF EXISTS gac.AREAS_OCIOSAS_GAC2;
CREATE TABLE gac.AREAS_OCIOSAS_GAC2

SELECT DISTINCT
149 as cd_vrv,  -- QT CONTRATOS A VENCER ATÉ 6 MESES
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERATE6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
150 as cd_vrv,  -- QT CONTRATOS A VENCER APÓS 6 MESES
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERAPOS6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
151 as cd_vrv,  -- QT CONTRATOS VENCIDOS
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@VENCIDO as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
152 as cd_vrv,  -- QT CONTRATOS VENCIDOS
10000 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ND as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
149 as cd_vrv,  -- QT CONTRATOS A VENCER ATÉ 6 MESES
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERATE6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
150 as cd_vrv,  -- QT CONTRATOS A VENCER APÓS 6 MESES
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERAPOS6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
151 as cd_vrv,  -- QT CONTRATOS VENCIDOS
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@VENCIDO as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
152 as cd_vrv,  -- QT CONTRATOS VENCIDOS
8558 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ND as vl_vrv, 
184 as cd_in

UNION 


SELECT DISTINCT
149 as cd_vrv,  -- QT CONTRATOS A VENCER ATÉ 6 MESES
9101 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERATE6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
150 as cd_vrv,  -- QT CONTRATOS A VENCER APÓS 6 MESES
9101 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@AVENCERAPOS6MESES as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
151 as cd_vrv,  -- QT CONTRATOS VENCIDOS
9101 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@VENCIDO as vl_vrv, 
184 as cd_in

UNION 

SELECT DISTINCT
152 as cd_vrv,  -- QT CONTRATOS VENCIDOS
9101 as cd_prf_depe, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref,  
@ND as vl_vrv, 
184 as cd_in
;

DROP TABLE IF EXISTS gac.AREAS_OCIOSAS_GAC3;
CREATE TABLE gac.AREAS_OCIOSAS_GAC3
SELECT DISTINCT
23 as cd_evt, 
184 as cd_in, 
2 as qlc_evt, 
9101 as cd_prf_depe,
CONCAT(cd_prf_depe_ocpt, ' ', nr_unvl_bem, ' ', nr_unvl_trrn, ' ', nr_adar_lcl) as nr_doc, 
@ANO_REF as ano_ref,  
@MES_REF as mes_ref, 
DATEDIFF(CURDATE() , 19600101) as dt_prct

FROM gac.AREAS_OCIOSAS
WHERE nm_tip_fxa_vnct_ctr NOT IN('A VENCER ATÉ 6 MESES', 'A VENCER APÓS 6 MESES')

ORDER BY nr_unvl_bem, nr_unvl_trrn, nr_adar_lcl ;

    
DELETE FROM gac.AREAS_OCIOSAS;
INSERT INTO gac.AREAS_OCIOSAS
SELECT DISTINCT
	a.cd_prf_csl,
	h.NM_UOR_RED AS nm_csl,
	b.cd_prf_depe_ocpt,
	b.cd_sag_depe_ocpt,
	a.nr_unvl_bem,
	a.nr_unvl_trrn,
	b.cd_str_lcl,
	a.cd_prf_depe_dttr,
	a.nm_depe_dttr,
	e.NM_UOR_RED AS nm_super,
	a.dcr_end,
	a.dcr_cid,
	a.sg_uf_cid,
	b.nr_adar_lcl,
	b.qt_area_ocpd_locl,
	CASE WHEN b.cd_res_ocpt LIKE 'OD' THEN 'OCIOSA DESOCUPADA' WHEN b.cd_res_ocpt LIKE 'OL' THEN 'OCIOSA LOCADA' WHEN b.cd_res_ocpt LIKE 'OC' THEN 'OCIOSA CEDIDA' ELSE 'OUTROS' END AS nm_res_ocpt,
	CASE WHEN cd_fma_aqs_bem IN (2, 12) THEN 'TERCEIROS' ELSE 'PRÓPRIO' END AS tip_imv,
	f.dt_ini_ctr,
	f.dt_fim_ctr,
	f.vl_aluguel,
	f.dcr_ocpt,
	CASE WHEN f.dt_fim_ctr IS NULL THEN 'N/D' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) < 0 THEN 'VENCIDO' WHEN DATEDIFF(f.dt_fim_ctr,CURDATE()) BETWEEN 0 AND 180 THEN 'A VENCER ATÉ 6 MESES' ELSE 'A VENCER APÓS 6 MESES' END AS nm_tip_fxa_vnct_ctr,
	f.in_cpsr_vnd,
	f.in_libd_vnd
	FROM
	crm.NIMV_UTZO a
	INNER JOIN crm.NIMV_UTZO_LCL b ON a.NR_UNVL_BEM=b.NR_UNVL_BEM
	INNER JOIN mstNovo.depe h ON h.CD_PRF = a.cd_prf_csl AND h.CD_SBDD=0
	INNER JOIN mstNovo.depe c ON c.CD_PRF = a.cd_prf_depe_dttr AND c.CD_SBDD=0
	LEFT JOIN mstNovo.depe_jrdc d ON d.CD_UOR_JRDD=c.CD_UOR AND d.CD_JRDC=1010
	LEFT JOIN mstNovo.depe e ON d.CD_UOR_JRDT=e.CD_UOR
	LEFT JOIN imoveis.NIMV_UTZO_CMPT f ON a.cd_tip_bem = f.cd_tip_bem AND a.nr_unvl_bem = f.nr_unvl_bem AND a.nr_unvl_trrn = f.nr_unvl_trrn AND b.nr_adar_lcl = f.nr_adar_lcl AND b.cd_prf_depe_ocpt=f.cd_prf_depe_ocpt AND b.cd_sag_depe_ocpt=f.cd_sag_depe_ocpt AND b.cd_str_lcl=f.cd_str_lcl
	WHERE 1
	and a.AA_MM_REF_INF=(EXTRACT(YEAR_MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)))
	and b.CD_RES_OCPT IN ('OC', 'OD', 'OL')
	and NOT (b.CD_RES_OCPT IN ('OD') AND f.dt_fim_ctr IS NULL)
	;
    
    
