<%-- 
    Document   : logout
    Created on : 26 nov 2025, 7:13:50 p.m.
    Author     : josem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ejercicio1.backend.usuarioBL"%>

<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />

<%
    try{
        session.removeAttribute("usuario");
        session.invalidate();

        response.sendRedirect("/ejercicio1/app/jsp/main/main.jsp");
        response.flushBuffer();
    }catch(Exception e){
        out.print(e.getMessage());
    }   


%>
