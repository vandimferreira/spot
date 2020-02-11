package br.com.bb.dinop.rtinContratosTAB_CTR.persistencia;

import java.sql.Connection;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import br.com.bb.dinop.aplicDefaultRtinLibs.exception.RtinException;
import br.com.bb.dinop.aplicDefaultRtinLibs.exception.RtinExceptionMap;
import br.com.bb.dinop.aplicDefaultRtinLibs.util.FabricaConexao;
import br.com.bb.dinop.aplicDefaultRtinLibs.util.XmlResources;

/**
 * @author F8712906
 *
 */
public class Persistencia {

	/**
	 * Apaga dados (TRUNCATE) da tabela
	 * @param connectionName Nome da query presente nos resources do connection.properties.xml
	 * @param queryName Nome da query presente nos resources do sql.properties.xml
	 */
	public static void apagaDadosTabela(String connectionName, String queryName){
		Connection conn = FabricaConexao.get(connectionName);
		Statement statement = null;
        if (null == conn) {
            return;
        }
        try{
        	statement = conn.createStatement();
			String sql = "";
			sql = XmlResources.getSqlResource("aplicDefaultRtin", queryName);
			statement.executeUpdate(sql);
			System.out.println(sql);
	        System.out.println("Truncate da tabela : " + StringUtils.replace(queryName, "truncate_", "") + " realizado com sucesso!");
	        return;
        	
        } catch (Exception e) {
			e.printStackTrace();
			throw new RtinException("Falha durante o truncate da tabela ", e, RtinExceptionMap.getCdExco(e.getMessage()));			
		}
		finally {
			FabricaConexao.fecharConexao(conn, statement);
		}
	}
	public static boolean atualizaDcrCtu(String connectionName, String cd_ctu){
		Connection conn = FabricaConexao.get(connectionName);
		
		Date dataHoraAtualizacao = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Statement statement = null;
		if (null == conn) {
			return false;
		}
		try{
			statement = conn.createStatement();
			String sql = "";
			sql = XmlResources.getSqlResource("aplicDefaultRtin", "atualiza_dcr_ctu");
			
			sql = StringUtils.replace(sql, "$cd_ctu", cd_ctu);
			
			sql = StringUtils.replace(sql, "$dataHoraAtualizacao", df.format(dataHoraAtualizacao));
			
			statement.executeUpdate(sql);
			
			System.out.println("dcr_ctu ("+cd_ctu+") atualizada com cucesso!");
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RtinException("Falha durante ao atualizar dcr_ctu ", e, RtinExceptionMap.getCdExco(e.getMessage()));			
		}
		finally {
			FabricaConexao.fecharConexao(conn, statement);
		}
	}
}
