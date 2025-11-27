<%-- 
    Document   : inventarioControlador
    Created on : 26 nov 2025, 11:00:44 a.m.
    Author     : josem
--%>

<%@page import="com.ejercicio1.backend.DatabaseConnectionBL"%>
<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    
if (usuario.getID()== 0) {
        out.print("{\"estatus\":\"error\",\"msg\":\"Se ha cerrado la sesión\"}");
}else{
  
    int idProducto = 0;
    int idAccion = 0;
    
    int idProductoAlmacen = 0;
    int inventario = 0;
    int inventario_anterior = 0;
    String nombre = "";
    
    try {
        idProducto = request.getParameter("idProducto") != null ? Integer.parseInt(request.getParameter("idProducto")) : 0;
    } catch (Exception e) {}
    try {
        idAccion = request.getParameter("idAccion") != null ? Integer.parseInt(request.getParameter("idAccion")) : 0;
    } catch (Exception e) {}
    try {
        inventario = request.getParameter("inventario") != null ? Integer.parseInt(request.getParameter("inventario")) : 0;
    } catch (Exception e) {}
    try {
        inventario_anterior = request.getParameter("inventario_anterior") != null ? Integer.parseInt(request.getParameter("inventario_anterior")) : 0;
    } catch (Exception e) {}
    try {
        nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
    } catch (Exception e) {}
    

    DatabaseConnectionBL modificarProducto = new DatabaseConnectionBL();
    /*
        Acciones
        1.- Nuevo producto
        2.- Entrada de inventario
        3.- Salida de inventario
        4.- Desactivar producto
        5.- Reactivar producto
    */
    if(idAccion == 1){
        /*
            Registro de producto
        */
        try{
            idProducto = modificarProducto.insert("ejercicio1.dbo.productos", "idEstatusFk, nombre, inventario", "5, '"+nombre+"', 0");
            out.print("{\"estatus\":\"exito\",\"registro\":\""+idProducto+"\"}");
        }catch(Exception e){
            out.print("{\"estatus\":\"error\",\"msg\":\""+e.getMessage()+"\"}");
        }   
        
    }else if(idAccion == 2 || idAccion == 3){
        DatabaseConnectionBL insertarHistorial = new DatabaseConnectionBL();
        if(idAccion == 2 && (inventario < inventario_anterior)){
            out.print("{\"estatus\":\"error\",\"msg\":\"Entrada de inventario no permite reducir la cantidad.\"}");
        }else if(idAccion == 3 && (inventario > inventario_anterior)){
            out.print("{\"estatus\":\"error\",\"msg\":\"Salida de inventario no permite aumentar la cantidad.\"}");
        }else{
            if(inventario > 0){
                try{
                    modificarProducto.update("ejercicio1.dbo.productos", "nombre='"+nombre+"', inventario='"+inventario+"'", "idProducto='"+idProducto+"'");
                    insertarHistorial.insert("ejercicio1.dbo.historial", "idEstatusFk, idProductoFk, idUsuarioFk, unidades", "3, "+idProducto+", 1, "+(inventario - inventario_anterior));
                    out.print("{\"estatus\":\"exito\",\"registro\":\""+idProducto+"\"}");
                }catch(Exception e){
                    out.print("{\"estatus\":\"error\",\"msg\":\""+e.getMessage()+"\"}");
                }
            }else{
                out.print("{\"estatus\":\"error\",\"msg\":\"La existencia no puede ser menor a 0\"}");
            }
        }        
    }else if(idAccion == 4 ){
        try{
            modificarProducto.update("ejercicio1.dbo.productos", "idEstatusFk='6'", "idProducto='"+idProducto+"'");            
            out.print("{\"estatus\":\"exito\",\"registro\":\""+idProducto+"\"}");
        }catch(Exception e){
            out.print("{\"estatus\":\"error\",\"msg\":\""+e.getMessage()+"\"}");
        }
    }else if(idAccion == 5 ){
        try{
            modificarProducto.update("ejercicio1.dbo.productos", "idEstatusFk='5'", "idProducto='"+idProducto+"'");            
            out.print("{\"estatus\":\"exito\",\"registro\":\""+idProducto+"\"}");
        }catch(Exception e){
            out.print("{\"estatus\":\"error\",\"msg\":\""+e.getMessage()+"\"}");
        }
    }
    
    
}
%>
