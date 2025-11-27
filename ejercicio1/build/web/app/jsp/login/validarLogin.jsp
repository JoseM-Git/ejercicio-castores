<%-- 
    Document   : validarLogin
    Created on : 26 nov 2025, 7:12:02 p.m.
    Author     : josem
--%>

<%@page import="com.ejercicio1.backend.DatabaseQuery"%>
<%@page import="com.ejercicio1.backend.usuarioBL"%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />

<%
    
    String email = "";
    String pwd = "";
        
    try {
        email = request.getParameter("email") != null ? request.getParameter("email").trim(): "";
    } catch (Exception e) {}
    try {
        pwd = request.getParameter("pwd") != null ? request.getParameter("pwd").trim(): "";
    } catch (Exception e) {}
    
    String sql_1 = ""
            +"select "
            +"u.idUsuario, "
            +"u.idRolFk, "
            +"u.nombre, "
            +"u.correo "
            +"from usuarios u "
            +"where u.correo = '"+email+"' and u.contrasena = '"+pwd+"'";
            
        DatabaseQuery queryLogin = new DatabaseQuery();
        try{        
             queryLogin.executeQueryAndStore(sql_1);
        }catch(Exception e){
        }
        
        if(queryLogin.getRecordCount() == 1){            
            usuarioBL usuario_temp = new usuarioBL(
                Integer.parseInt(queryLogin.getDataAsStringNotNull(0, "idUsuario")),
                Integer.parseInt(queryLogin.getDataAsStringNotNull(0, "idRolFk")),
                queryLogin.getDataAsStringNotNull(0, "nombre"),
                queryLogin.getDataAsStringNotNull(0, "correo")
            );
            session.setAttribute("usuario", usuario_temp);
            out.print("{\"estatus\":\"exito\"}");
        }else{
            out.print("{\"estatus\":\"error\",\"msg\":\"El usuario o contraseña son incorrectos\"}");
        }        

%>
