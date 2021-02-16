package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

public class Conexion {

    private final String url = "jdbc:postgresql://127.0.0.1:5432/pl2";
    private final String user;
    private final String password;
    private final Logger logger = Logger.getLogger(Conexion.class.getName());
    private Connection conn = null;
    
    private boolean b = false;

    public Connection connect() {
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Conectado!!");
            this.b = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            System.out.println("Driver no detectado");
        }
        return conn;
    }

    public Conexion(String user, String password) {
        this.user = user;
        this.password = password;
    }

    public boolean getB() {
        return b;
    }

    public void disconnect() {
        try {
            conn.close();
            System.out.println("Desconectado!!");
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "No se ha podido cerrar la conexión", ex);
        } catch (Exception ex) {
            logger.log(Level.WARNING, "Excepción capturada", ex);
        }
    }

 public void getConsulta1(JTextArea panel) {
        try {
            String a = "";
            String query = "select * from \"Grupo\" where \"Género\"='Jazz';";
            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los grupos de género jazz\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() +"    "+ rs.getString(2).trim() +  " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }

    }

    public void getConsulta2(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Nombre\" from \"Músico\" where \"Instrumento\"='Batería'";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los músicos que tocan la batería\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() +  " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta3(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Nombre\" from \"Músico\" inner join \"Grupo\" on \n"
                    + "\"Grupo\".\"Código Grupo\"=\"Músico\".\"Código Grupo_Grupo\" where \"Grupo\".\"Género\"='Jazz' and  \"Músico\".\"Instrumento\"='Saxofón';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los saxofonistas de Jazz\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim()   + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }
    public void getConsulta4(JTextArea panel) {
        try {
            String a = "";
            String query = "select distinct \"Grupo\".* from \"Grupo\" inner join \"muchos_Concierto_tiene_muchos_Grupo\" on \"muchos_Concierto_tiene_muchos_Grupo\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\"\n"
                    + "inner join \"Concierto\" on \"muchos_Concierto_tiene_muchos_Grupo\".\"Código_Concierto\"=\"Concierto\".\"Código\" where \"Concierto\".\"País\"='España';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los conciertos dados en España\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + (rs.getString(1).trim() +"    "+  rs.getString(2).trim() +  " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta5(JTextArea panel) {
        try {
            String a = "";
            String query = "select distinct count(\"Número de referencia_Disco\"),\"Disco\".\"Título\" from \"Disco\", \"Canción\" group by \"Número de referencia_Disco\",\"Disco\".\"Título\" having count(\"Número de referencia_Disco\")>10 ;";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los discos con más de 10 canciones\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + "    "+ rs.getString(2).trim()  +  " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta6(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Grupo\".* from \"Grupo\" inner join \"Músico\" on \"Músico\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\" group by \"Código Grupo\" having count(\"Código Grupo\")>3;";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los grupos con más de 3 miembros\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + "    "+ rs.getString(2).trim()  +  " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta7(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Opinion Disco\" from \"Opinion\" where \"DNI_Usuario\" in"
                    + "(select \"DNI_Usuario\" from \"Opinion\" group by \"DNI_Usuario\" having count(\"DNI_Usuario\")>3);";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de todas las opiniones de los discos emitidas por usuarios que hayan comprado al menos tres discos \n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta8(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Disco\".* from \"Disco\" inner join \"Canción\" on \"Canción\".\"Número de referencia_Disco\"=\"Disco\".\"Número de referencia\" inner join \"Grupo\" on \"Grupo\".\"Código Grupo\"=\"Disco\".\"Código Grupo_Grupo\" \n"
                    + "where \"Duración\">='05:00:00' and \"Grupo\".\"Género\"='Rock';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de discos que tengan como mínimo una canción de \nmás de 5 min y haya sido grabado por un grupo de Rock\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim()  + "    "+rs.getString(2).trim() +"    "+ rs.getString(3).trim() +"    "+ rs.getString(4).trim() +"    "+ rs.getString(5).trim() +
                        "    "+rs.getString(6).trim() +"    "+ rs.getString(7).trim()  + "    "+rs.getString(8).trim()  +"    "+ " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta9(JTextArea panel) {
        try {
            String a = "";
            String query = "select distinct \"Nombre\" from \"Músico\" inner join \"Grupo\" on \"Grupo\".\"Código Grupo\"=\"Músico\".\"Código Grupo_Grupo\" \n"
                    + "inner join \"muchos_Concierto_tiene_muchos_Grupo\" on \"muchos_Concierto_tiene_muchos_Grupo\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\"\n"
                    + "inner join \"Concierto\" on \"muchos_Concierto_tiene_muchos_Grupo\".\"Código_Concierto\"=\"Concierto\".\"Código\" \n"
                    + "inner join \"Entrada\" on \"Entrada\".\"Código_Concierto\"=\"Concierto\".\"Código\" \n"
                    + "where \"Concierto\".\"Ciudad\"='Madrid' and \"Entrada\".\"Precio\">'100';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de músicos que han dado conciertos en Madrid y han puesto \na la venta entradas con un precio superior a 100€\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta10(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Opinion concierto\" from \"Opinion\" inner join \"Concierto\" on \"Opinion\".\"Código_Concierto\"=\"Concierto\".\"Código\" \n"
                    + "inner join \"Entrada\" on \"Entrada\".\"Código_Concierto\"=\"Concierto\".\"Código\" \n"
                    + "where \"Concierto\".\"Ciudad\"='Madrid' and \"Entrada\".\"Precio\">'100';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de opiniones de los conciertos dados \nen Madrid cuyo precio es superior a 100€\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta11(JTextArea panel) {///////////////////
        try {
            String a = "";
            String query = "select \"Canción\".\"Nombre\",\"Músico\".\"Nombre\" from \"Canción\" inner join \"Músico\" on \"Músico\".\"DNI\"=\"Canción\".\"DNI_Músico\" \n"
                    + "inner join \"Disco\" on \"Disco\".\"Número de referencia\"=\"Canción\".\"Número de referencia_Disco\" where \"Disco\".\"Género\"='Heavy Metal' and (\"Disco\".\"Fecha\"<'31/12/2018 23:59:59' \n"
                    + "or \"Disco\".\"Fecha\">'1/1/2018 00:00:00');";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de canciones y el nombre del compositor de los \ndiscos publicados en el año 2018 de Heavy Metal \n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + "    "+rs.getString(2).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta12(JTextArea panel) {/////////////
        try {
            String a = "";
            String query = "select \"Nombre\",\"Disco\".\"Tipo\",\"Disco\".\"Tamaño (MB)\" from \"Músico\" inner join \"Grupo\" on \"Grupo\".\"Código Grupo\"=\"Músico\".\"Código Grupo_Grupo\" inner join \n"
                    + "\"Disco\" on \"Disco\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\"\n"
                    + " where \"Músico\".\"Instrumento\"='Guitarra' and \"Grupo\".\"Género\"='Jazz' and \"Disco\".\"Formato\"='Digital';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de los guitarristas de Jazz y los discos \ndigitales junto a su formato y tamaño en MB\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + "    "+rs.getString(2).trim() + "    "+rs.getString(3).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta13(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Nombre\", \"Apellidos\" from \"Usuario\" inner join \"Entrada\" on \"Usuario\".\"DNI\"=\"Entrada\".\"DNI_Usuario\" \n"
                    + "inner join \"Concierto\" on \"Concierto\".\"Código\"=\"Entrada\".\"Código_Concierto\" inner join \"muchos_Concierto_tiene_muchos_Grupo\" on \n"
                    + "\"muchos_Concierto_tiene_muchos_Grupo\".\"Código Grupo_Grupo\"=\"Concierto\".\"Código\"\n"
                    + "inner join \"Grupo\" on \"muchos_Concierto_tiene_muchos_Grupo\".\"Código_Concierto\"=\"Concierto\".\"Código\" inner join \"Opinion\" on\n"
                    + "\"Opinion\".\"Código_Concierto\"=\"Concierto\".\"Código\"  where \"Grupo\".\"Género\"='Blues' and\n"
                    + "\"Concierto\".\"Fecha\"<'31/12/2018 23:59:59' and \"Concierto\".\"Fecha\">'1/1/2018 00:00:00';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de nombre y apellidos de los usuarios que han comprado \nentradas para los conciertos celebrados en 2018 de grupos de \nblues y hayan emitido alguna opinión sobre esos conciertos\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() +"    "+ rs.getString(2).trim()+ " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta14(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Disco\".\"Título\", \"Canción\".\"Nombre\" as Disco from \"Disco\" inner join \"Canción\" on \"Disco\".\"Número de referencia\"=\"Canción\".\"Número de referencia_Disco\"\n"
                    + "where \"Disco\".\"Título\" in (select \"Título\" from \"Disco\" inner join \"Opinion\" on \"Opinion\".\"Número de referencia_Disco\"=\"Disco\".\"Número de referencia\" where \"Opinion Disco\">8);";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado de título, junto con las canciones que lo componen de \naquellos discos cuyas opiniones de los usuarios que los han \ncomprado superan la puntuación de 8/10\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() + "    "+rs.getString(2).trim()  + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta15(JTextArea panel) {
        try {
            String a = "";
            String query = "select \"Grupo\".*,\"Músico\".\"Nombre\" from \"Músico\" inner join \"Grupo\" on \"Grupo\".\"Código Grupo\"=\"Músico\".\"Código Grupo_Grupo\"\n"
                    + "inner join \"Disco\" on \"Grupo\".\"Código Grupo\"=\"Disco\".\"Código Grupo_Grupo\" inner join \"muchos_Concierto_tiene_muchos_Grupo\" on \n"
                    + "\"muchos_Concierto_tiene_muchos_Grupo\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\" inner join \"Concierto\" on \n"
                    + "\"muchos_Concierto_tiene_muchos_Grupo\".\"Código_Concierto\"=\"Concierto\".\"Código\" where not(\"País\"='España')\n"
                    + "and \"Disco\".\"Número de referencia\" in (select \"Número de referencia_Disco\" from \"Canción\" group by \"Número de referencia_Disco\" \n"
                    + "having count(\"Número de referencia_Disco\")>10);";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado con el nombre de los grupos y los músicos que lo componen que no hayan dado conciertos en España y hayan grabado discos con más de 10 canciones \n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + ( rs.getString(1).trim() +"    "+ rs.getString(2).trim() + "    "+rs.getString(3).trim()  + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }

    public void getConsulta16(JTextArea panel) {///////////////
        try {
            String a = "";
            String query = "select distinct \"Canción\".\"Nombre\",\"Músico\".\"Nombre\" from \"Canción\" inner join \"Músico\" on \"Músico\".\"DNI\"=\"Canción\".\"DNI_Músico\" \n"
                    + "inner join \"Grupo\" on \"Grupo\".\"Código Grupo\"=\"Músico\".\"Código Grupo_Grupo\" inner join \"muchos_Concierto_tiene_muchos_Grupo\" on \n"
                    + "\"muchos_Concierto_tiene_muchos_Grupo\".\"Código Grupo_Grupo\"=\"Grupo\".\"Código Grupo\" inner join \"Concierto\" on\n"
                    + "\"Concierto\".\"Código\"=\"muchos_Concierto_tiene_muchos_Grupo\".\"Código_Concierto\" where \"Concierto\".\"Fecha\"<'1/1/2017 00:00:00' or \"Concierto\".\"Fecha\">'31/12/2018 23:59:59';";

            //String query ="select * from \"Grupo\" where \"Género\"='Jazz';";
            Statement stmnt = conn.createStatement();
            ResultSet rs = stmnt.executeQuery(query);

            a = a + ("Listado con los nombres de las canciones y los nombres de músicos que las han \ncompuesto grabadas por grupos que no han dado ningún concierto en el año 2017\n");
            a = a + ("============================\n");
            while (rs.next()) {
                a = a + (rs.getString(1).trim() + "    "+rs.getString(2).trim() + " \n");

            }
            a = a + ("============================");
            panel.setText(a);
        } catch (SQLException ex) {
            //panel.setText(ex.getMessage());
            logger.log(Level.WARNING, "SQL Exception", ex);
        }
    }
    

    
    public void consulta(String sql, JTextArea panel){
        try{
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            
            String pantalla = "";
            pantalla = pantalla + "Listado de la consulta SQL.\n";
            pantalla = pantalla + "***********\n";
            
            while(rs.next()){
                for(int i=1; i<=rs.getMetaData().getColumnCount(); i++){
                    //Clausula if para que no se pongan por pantalla los espacios al final de fila
                    if(rs.getString(i)!=null){
                        if(i==rs.getMetaData().getColumnCount()){
                            pantalla = pantalla +"    " + rs.getString(i)+ "\n";
                        }else{
                            pantalla = pantalla +"    " + rs.getString(i);   
                        }
                    }
                }
            }
            
            panel.setText(pantalla);
            
        }catch(SQLException e){
            System.out.println(e.getMessage());
            JOptionPane.showMessageDialog(null,e.getMessage());
        }
    }
    
}
