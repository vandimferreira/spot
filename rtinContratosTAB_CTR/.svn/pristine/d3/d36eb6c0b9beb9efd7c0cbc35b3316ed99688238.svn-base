package br.com.bb.dinop.rtinContratosTAB_CTR.view;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;

import br.com.bb.dinop.aplicDefaultRtinLibs.exception.RtinException;
import br.com.bb.dinop.aplicDefaultRtinLibs.persistencia.LoadPersistencia;
import br.com.bb.dinop.aplicDefaultRtinLibs.persistencia.RtinPersistencia;
import br.com.bb.dinop.aplicDefaultRtinLibs.util.FabricaConexao;
import br.com.bb.dinop.aplicDefaultRtinLibs.util.XmlResources;
import br.com.bb.dinop.rtinContratosTAB_CTR.persistencia.Persistencia;

public class Main {

	public static ArrayList<Thread> threads;
	
	public static final int idRtin = 56; //CODIGO REFERENTE AO CADASTRO NA APLICACAO DE CONTROLE DE ROTINAS
	public static final String cdServer = "103"; //CODIGO REFERENTE AO SERVIDOR DE ATUALIZACAO (cat_rtin.tb_server_rtin)
	public static final boolean isProd = true;
	
	//PARTE DINÂMICA
	public static final String caminho = "/dados/arquivos/contratos/";
	//public static final String caminho = "C:/Users/f6472569/Desktop/";
	
	public static final String filePgtoCtr = "TAB_CTR";	

	public static void main(String[] args) throws InterruptedException {		
		
		
		RtinPersistencia.init(Main.isProd, Main.idRtin, Main.cdServer);
		
		Connection conn = FabricaConexao.get(cdServer);
		PreparedStatement ps = null;
		Statement st = null;
		boolean rs = true;
        if (null == conn) {
            return;
        }
                
        try { //TRUNCANDO A TABELA TEMPORARIA
        
        	conn.setAutoCommit(false);
        	        	
			ps = conn.prepareStatement("TRUNCATE TABLE temp.contratos_TAB_CTR;");
			rs = ps.execute();
			System.out.println( "TRUNCATE OK temp.contratos_TAB_CTR" );
			
			ps = conn.prepareStatement("TRUNCATE TABLE contratos.TAB_CTR;");
			rs = ps.execute();
			System.out.println( "TRUNCATE OK contratos.TAB_CTR" );
			
			conn.commit();
										
        } catch (Exception e) {
			e.printStackTrace();
			throw new RtinException("Falha durante o truncate da tabela temporaria.", e);
		}
		finally {
			FabricaConexao.fecharConexao(conn, ps);
		}
						
        
        //CARREGANDO O ARQUIVO NA TABELA TEMPORARIA
		LoadPersistencia.loadFile(caminho + filePgtoCtr + ".TXT", cdServer, "aplicDefaultRtin",  "load_tb_tab_ctr", false);		
		
		
		//INSERINDO OS DADOS NA TAB_CTR
		conn = FabricaConexao.get(cdServer);
		ps = null;
		st = null;
		rs = true;
        if (null == conn) {
            return;
        }
               		
		try {
	        
        	conn.setAutoCommit(false);
        	
			String sql = "";
			sql = XmlResources.getSqlResource("aplicDefaultRtin",  "insert_tb_tab_ctr");
        	        	
			ps = conn.prepareStatement(sql);
			rs = ps.execute();
			System.out.println( "INSERT OK" );
			
			conn.commit();
										
        } catch (Exception e) {
			e.printStackTrace();
			throw new RtinException("Falha durante o insert.", e);
		}
		finally {
			FabricaConexao.fecharConexao(conn, ps);
		}
		
		
		RtinPersistencia.fim();
		
	}
	
}
