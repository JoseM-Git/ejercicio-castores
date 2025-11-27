<%-- 
    Document   : inventarioLista
    Created on : 26 nov 2025, 11:00:24 a.m.
    Author     : josem
--%>

<%@page import="com.ejercicio1.backend.DatabaseQuery"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />
<%
if (usuario.getID()== 0) {
        response.sendRedirect("/ejercicio1/app/jsp/login/login.jsp");
        response.flushBuffer();
}else{
  
%>
<%
    String msg = "";
    /***
     * Entrada de almacen
     */
    String sql_1 = "select "
    +"p.idProducto, "
    +"p.idEstatusFk, "
    +"CASE WHEN p.idEstatusFk = 5 THEN '<span class=\"badge rounded-pill text-bg-success\">Activo</span>' ELSE '<span class=\"badge rounded-pill text-bg-danger\">Inactivo</span>' END as estatus, "
    +"p.nombre, "
    +"p.inventario "
    +"from productos p ";
    DatabaseQuery queryEntradas = new DatabaseQuery();
    try{        
        queryEntradas.executeQueryAndStore(sql_1);
    }catch(Exception e){
        msg = e.getMessage();
    }
    /***
     * Salida de almacen
     */
    String sql_2 = "select "
    +"p.idProducto, "
    +"'<span class=\"badge rounded-pill text-bg-success\">Activo</span>' as idEstatusFk, "
    +"p.nombre, "
    +"p.inventario "
    +"from productos p "
    +"where p.idEstatusFk = 5 ";        
    DatabaseQuery querySalidas = new DatabaseQuery();
    try{        
        querySalidas.executeQueryAndStore(sql_2);
    }catch(Exception e){
        msg = e.getMessage();
    }
    /***
     * Historial
     */
    String sql_3 = ""
    +"select "
    +"p.nombre, "
    +"CASE WHEN h.unidades > 0 THEN '<span class=\"badge rounded-pill text-bg-primary\">Entrada ('+concat('',h.unidades)+')</span>' ELSE '<span class=\"badge rounded-pill text-bg-warning\">Salida ('+concat('',h.unidades)+')</span>' END as movimiento, "
    +"h.idUsuarioFk, "
    +"FORMAT(h.fecha, 'dd/MM/yyyy hh:mm') AS fecha "
    +"from historial h "
    +"left join productos p on p.idProducto = h.idProductoFk ";
    DatabaseQuery queryHistorial = new DatabaseQuery();
    try{        
        queryHistorial.executeQueryAndStore(sql_3);
    }catch(Exception e){
        msg = e.getMessage();
    }
%>
<jsp:include page="/app/jsp/yield/head.jsp"/>
<jsp:include page="/app/jsp/yield/header.jsp"/>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.5/css/dataTables.dataTables.css" />
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/app/jsp/yield/sidebar.jsp"/>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Inventario</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <%
                            if(usuario.getRol() == 1){
                        %>
                        <a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=0&idAccion=1" type="button" class="btn btn-sm btn-outline-secondary">
                            Nuevo Producto
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <ul class="nav nav-tabs" id="tabs" role="tablist">
                    <li class="nav-item" role="inventarios">
                      <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#entrada-productos" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">Entradas</button>
                    </li>
                    <li class="nav-item" role="inventarios">
                      <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#salida-productos" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Salidas</button>
                    </li>
                    <li class="nav-item" role="inventarios">
                      <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#historial" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">Historial</button>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="entrada-productos" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
                        <table class="table table-striped table-sm w-100" id="">
                            <thead>
                                <tr>
                                    <th>ID Producto</th>
                                    <th>Estatus</th>
                                    <th>Cantidad</th>
                                    <th>Titulo</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%    
                                    if(usuario.getRol() == 1){                    
                                        for(int i = 0; i<queryEntradas.getRecordCount(); i++){
                                %>                                    
                                <tr>
                                    <td><%=queryEntradas.getDataAsStringNotNull(i, "idProducto") %></td>
                                    <td><%=queryEntradas.getDataAsStringNotNull(i, "estatus") %></td>
                                    <td><%=queryEntradas.getDataAsStringNotNull(i, "inventario") %></td>
                                    <td><%=queryEntradas.getDataAsStringNotNull(i, "nombre") %></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                              Acciones
                                            </button>
                                            <ul class="dropdown-menu">
                                              <li>
                                                  <a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=<%=queryEntradas.getDataAsStringNotNull(i, "idProducto")%>&idAccion=2" 
                                                     class="dropdown-item" href="#">Entrada</a>
                                              </li>
                                              <%
                                              if(Integer.parseInt(queryEntradas.getDataAsStringNotNull(i, "idEstatusFk")) == 5){
                                              %>
                                              <li>
                                                  <a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=<%=queryEntradas.getDataAsStringNotNull(i, "idProducto")%>&idAccion=4"
                                                     class="dropdown-item" href="#">Desactivar</a>
                                              </li>
                                              <%
                                                  }else{
                                              %>
                                              <li>
                                                  <a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=<%=queryEntradas.getDataAsStringNotNull(i, "idProducto")%>&idAccion=5"
                                                     class="dropdown-item" href="#">Activar</a>
                                              </li>
                                              <%
                                                  }
                                              %>
                                            </ul>
                                        </div>
                                    </td>                                    
                                </tr>
                                <%
                                        }
                                    }else{
                                %>
                                    <div class="alert alert-warning rounded-0 border-0 border-start border-warning text-start w-100" id="login-response">
                                     Este usuario no tiene acceso a este contenido.
                                    </div>
                                <%    
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="salida-productos" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                        <table class="table table-striped table-sm w-100" id="">
                            <thead>
                                <tr>
                                    <th>ID Producto</th>
                                    <th>Estatus</th>
                                    <th>Cantidad</th>
                                    <th>Titulo</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  
                                    if(usuario.getRol() == 2){
                                        for(int i = 0; i<querySalidas.getRecordCount(); i++){
                                %>                                    
                                <tr>
                                    <td><%=querySalidas.getDataAsStringNotNull(i, "idProducto") %></td>
                                    <td><%=querySalidas.getDataAsStringNotNull(i, "idEstatusFk") %></td>
                                    <td><%=querySalidas.getDataAsStringNotNull(i, "inventario") %></td>
                                    <td><%=querySalidas.getDataAsStringNotNull(i, "nombre") %></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                              Acciones
                                            </button>
                                            <ul class="dropdown-menu">
                                              <li><a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=<%=querySalidas.getDataAsStringNotNull(i, "idProducto")%>&idAccion=3" 
                                                     class="dropdown-item" href="#">Salida</a></li>
                                              <li><a href="/ejercicio1/app/jsp/inventario/inventarioForm.jsp?idProducto=<%=querySalidas.getDataAsStringNotNull(i, "idProducto")%>&idAccion=4"
                                                     class="dropdown-item" href="#">Desactivar</a></li>
                                            </ul>
                                        </div>
                                    </td>                                    
                                </tr>
                                <%
                                        }
                                    }else{
                                %>
                                    <div class="alert alert-warning rounded-0 border-0 border-start border-warning text-start w-100" id="login-response">
                                     Este usuario no tiene acceso a este contenido.
                                    </div>
                                <%    
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="historial" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
                        <table class="table table-striped table-sm w-100" id="historial-tabla">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Movimiento</th>
                                    <th>Usuario</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  
                                    if(usuario.getRol() == 1){
                                        for(int i = 0; i<queryHistorial.getRecordCount(); i++){
                                %>                                    
                                <tr>
                                    <td><%=queryHistorial.getDataAsStringNotNull(i, "nombre") %></td>
                                    <td><%=queryHistorial.getDataAsStringNotNull(i, "movimiento") %></td>
                                    <td><%=queryHistorial.getDataAsStringNotNull(i, "idUsuarioFk") %></td>
                                    <td><%=queryHistorial.getDataAsStringNotNull(i, "fecha") %></td>
                                </tr>
                                <%
                                        }
                                    }else{
                                %>
                                    <div class="alert alert-warning rounded-0 border-0 border-start border-warning text-start w-100" id="login-response">
                                     Este usuario no tiene acceso a este contenido.
                                    </div>
                                <%    
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </div>
        </main>
    </div>
</div>

<jsp:include page="/app/jsp/js/js.jsp"/>
<jsp:include page="/app/jsp/yield/footer.jsp"/>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.js"></script>
<script>
    $(document).ready(function () {
        $('#historial-tabla').DataTable({
            order: [[0, 'desc']],
            pageLength: 25,
            lengthMenu: [10, 25, 50, 100],
            columnDefs: [
                {
                    targets: '_all',
                    className: 'px-1 text-center'
                }
            ]
        });
        
    });
</script>
<%
    }
%>