/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ejercicio1.backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author josem
 */
public class DatabaseConnectionBL {
    private Connection co;
    private Statement stm;
    
    private String DATABASE_HOST = "127.0.0.1";
    private String DATABASE_PORT = "1433";
    private String DATABASE_NAME = "ejercicio1";
    private String DATABASE_USER = "admin";
    private String DATABASE_PWD = "123";
    
    private String idTable = "";
    private String SQLCommand_Header = "";
    private String SQLCommand_Table = "";
    private String SQLCommand_Values = "";
    private String SQLCommand_ParamNames = "";
    private String SQLCommand_Conditions = "";
    private String SQLCommand_UpdateValues = "";
    private String FullSQLCommand = "";
    private String msgError = "";
    private String methodError = "";
    private String traceError = "";
    private String sqlError = "";
    
    private void DBOpenConnection() throws Exception {
        DBOpenConnection("ejercicio1");
    }

    private void DBOpenConnection(String databaseName) throws Exception {
        if (databaseName.equals("ejercicio1")) {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.co = DriverManager.getConnection(
                    "jdbc:sqlserver://"
                    + this.DATABASE_HOST + ":" + this.DATABASE_PORT
                    + ";databaseName=" + this.DATABASE_NAME
                    + ";user=" + this.DATABASE_USER
                    + ";password=" + this.DATABASE_PWD
                    + ";encrypt=false;");
        }else{
            throw new Exception("La base de datos ["+databaseName+"] no está declarada.");
        }
        co.setAutoCommit(false);
        this.stm = this.co.createStatement();
    }

    private void DBCloseConnection() throws Exception {
        try {
            co.close();
        } catch (Exception e) {
            throw new Exception("Error al cerrar la conexión: " + e.getMessage());
        }
    }

    private void DBRollbackConnection() throws Exception {
        try {
            co.rollback();
        } catch (Exception e) {
            throw new Exception("Error al regresar a un punto seguro: " + e.getMessage());
        }
    }

    private void DBCommitConnection() throws Exception {
        try {
            co.commit();
        } catch (Exception e) {
            throw new Exception("Error al confirmar los cambios en BD: " + e.getMessage());
        }
    }
    
    private String buildInsertSqlQuery() {
        FullSQLCommand = "INSERT INTO " + SQLCommand_Table + "(" + SQLCommand_ParamNames + ") values(" + SQLCommand_Values + ")";

        return FullSQLCommand;
    }

    private String buildUpdateSqlQuery() throws Exception {
        /**
         * Validamos que si tengamos, tabla, pk y id del registro.
         */
        if (!SQLCommand_Table.equals("") && !SQLCommand_Conditions.equals("")) {
            FullSQLCommand = "UPDATE " + SQLCommand_Table + " SET " + SQLCommand_UpdateValues + " WHERE " + SQLCommand_Conditions;
        } else {
            throw new Exception("Debe declararse una llave primaria para actualizar registros.");
        }

        return FullSQLCommand;
    }
    
    public int insert(String tableName, String columns, String values) throws Exception {
        String sql = "";
        this.SQLCommand_Table = tableName;
        this.SQLCommand_ParamNames = columns;
        this.SQLCommand_Values = values;
        ResultSet rs = null;
        int lastIdProcess = -1;
        try {
            DBOpenConnection("ejercicio1");
        } catch (Exception e) {
            throw new Exception("Error al conectar con BD: [" + e.getMessage() + "]<br>");
        }
        try {
            sql = buildInsertSqlQuery();
            stm.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                lastIdProcess = rs.getInt(1);
            } else {
                throw new Exception("No se obtuvo el id del registro insertado.");
            }
        } catch (Exception e) {
            this.DBRollbackConnection();
            msgError = e.getMessage() + "SQL["+this.FullSQLCommand+"]";
            throw new Exception(msgError);
        } finally {
            this.DBCommitConnection();
            this.DBCloseConnection();
        }

        return lastIdProcess;
    }

    public int update(String tableName, String values, String conditions) throws Exception {
        String sql = "";
        this.SQLCommand_Table = tableName;
        this.SQLCommand_UpdateValues = values;
        this.SQLCommand_Conditions = conditions;
        ResultSet rs = null;
        int lastIdProcess = -1;
        try {
            DBOpenConnection("ejercicio1");
        } catch (Exception e) {
            throw new Exception("Error al conectar con BD: [" + e.getMessage() + "]<br>");
        }
        try {
            sql = buildUpdateSqlQuery();
            lastIdProcess = stm.executeUpdate(sql);
        } catch (Exception e) {
            this.DBRollbackConnection();
            this.msgError = e.getMessage();
            throw new Exception(msgError);

        } finally {
            this.DBCommitConnection();
            this.DBCloseConnection();
        }

        return lastIdProcess;
    }
}
