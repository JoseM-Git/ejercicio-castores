/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ejercicio1.backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author josem
 */
public class DatabaseQuery {

    private String DATABASE_HOST = "127.0.0.1";
    private String DATABASE_PORT = "1433";
    private String DATABASE_NAME = "ejercicio1";
    private String DATABASE_USER = "admin";
    private String DATABASE_PWD = "123";

    private int QUERY_RECORD_COUNT = 0;
    private String[] dataTableColumnNames = null;
    private String stringDataTableColumnNames = "";
    private JSONObject executedQueryObject = new JSONObject();

    private JSONArray errors = new JSONArray();
    private boolean hasBeenExecuted = false;

    public void DBAmpleQueryBL(String query) {

    }

    @SuppressWarnings("empty-statement")
    public void executeQueryAndStore(String AmpleQuery) throws Exception {
        /**
         * Se ejecuta el query completo y se almacenan todos los datos en
         * arreglos.
         */

        String msgError = "";
        if (errors.isEmpty()) {
            try {
                JSONArray datos = new JSONArray();
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                try (Connection co = DriverManager.getConnection(
                        "jdbc:sqlserver://"
                        + this.DATABASE_HOST + ":" + this.DATABASE_PORT
                        + ";databaseName=" + this.DATABASE_NAME
                        + ";user=" + this.DATABASE_USER
                        + ";password=" + this.DATABASE_PWD
                        + ";encrypt=false;")) {
                    Statement stm = co.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    ResultSet rs = stm.executeQuery(AmpleQuery);
                    /**
                     * Se obtiene el nombre de las columnas
                     */
                    ResultSetMetaData resultSetMetaData = rs.getMetaData();

                    /**
                     * Se obtiene el número de columnas obtenido.
                     */
                    int count = resultSetMetaData.getColumnCount();
                    /**
                     * Obtenemos las columnas de los metadatos del statement.
                     */
                    try {
                        for (int i = 1; i <= count; i++) {
                            if (resultSetMetaData.getColumnLabel(i) != null && !resultSetMetaData.getColumnLabel(i).equals("")) {
                                /**
                                 * Se guarda el nombre de la columna.
                                 */
                                this.stringDataTableColumnNames += resultSetMetaData.getColumnLabel(i) + ",";

                            } else {
                                /**
                                 * Si no se recibe nombre de la columna se
                                 * asigna uno por defecto.
                                 */
                                this.stringDataTableColumnNames += "columna_sin_nombre_" + i + ",";
                            }
                        }
                    } catch (SQLException e) {
                        msgError += "(90)" + e.getMessage() + " columnas[" + count + "]<br>";
                        throw new Exception(msgError);
                    }
                    this.dataTableColumnNames = this.stringDataTableColumnNames.substring(0, this.stringDataTableColumnNames.length() - 1).split(",");
                    //***************************************************************
                    /**
                     * Se obtienen los valores de los datos.
                     */
                    while (rs.next()) {
                        //Cicla entre registros de una consulta
                        this.QUERY_RECORD_COUNT++;
                    }
                    rs.beforeFirst();
                    for (int i = 0; i < count; i++) {

                        //Cicla entre datos de un registro
                        datos = new JSONArray();
                        while (rs.next()) {
                            //Cicla entre registros de una consulta
                            datos.add((rs.getString(i + 1) == null ? "" : rs.getString(i + 1)));;
                        }
                        rs.beforeFirst();

                        /**
                         * Se almacenan los datos obtenidos, en un JSONObject.
                         */
                        try {

                            this.executedQueryObject.put(this.dataTableColumnNames[i], datos);

                        } catch (Exception e) {
                            msgError = "(123)" + e.getLocalizedMessage() + "<br>" + msgError + "<br>";
                            throw new Exception(msgError);
                        }
                    }

                    rs.close();
                    stm.close();
                }
                this.hasBeenExecuted = true;
            } catch (Exception ex) {
                throw new Exception(ex.getMessage());
            }
        }
    }

    public String getDataAsStringNotNull(int i, String dataName) throws Exception {
        if (hasBeenExecuted) {
            /**
             * Se se ejecutó correctamente el query.
             */
            JSONParser parser = new JSONParser();
            JSONArray array = new JSONArray();
            try {
                if (this.executedQueryObject.containsKey(dataName)) {
                    /**
                     * Mapea columna[i]-dato[j] en un arreglo para que sea más
                     * cómodo de manejar.
                     */
                    Object obj = parser.parse("" + this.executedQueryObject.get(dataName));
                    array = (JSONArray) obj;
                } else {
                    /**
                     * Si no se encuentra el dato, se devuelve cadena vacía.
                     */
                    return ("");
                }
            } catch (ParseException e) {
                throw new Exception("Error al obtener el dato. (" + e.getMessage() + ")");
            }
            return "" + array.get(i).toString();
        } else {
            /**
             * Si detecta que la consulta no se ejecutó correctamente o en
             * absoluto.
             */
            throw new Exception("La consulta no ha sido ejecutada.");
        }
    }
    public int getRecordCount(){
        return this.QUERY_RECORD_COUNT;
    }
}
