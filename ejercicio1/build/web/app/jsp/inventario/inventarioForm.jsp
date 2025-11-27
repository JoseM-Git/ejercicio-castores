<%-- 
    Document   : inventarioForm
    Created on : 26 nov 2025, 11:00:32 a.m.
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
        int idProducto = 0;
        int idAccion = 0;
        int inventario = 0;
        String titulo = "";
        String nombre = "";
        try{
            idProducto = request.getParameter("idProducto")==null?0:Integer.parseInt(request.getParameter("idProducto"));
        }catch(Exception e){}
        try{
            idAccion = request.getParameter("idAccion")!=null?Integer.parseInt(request.getParameter("idAccion")):idAccion;
        }catch(Exception e){}
        String sql_1 = "select "
            +"p.idProducto, "
            +"p.idEstatusFk, "
            +"p.nombre, "
            +"p.inventario "
            +"from productos p "
            +"where p.idProducto = " + idProducto;
        
        DatabaseQuery queryProducto = new DatabaseQuery();
        
        if(idProducto > 0){
           try{        
                queryProducto.executeQueryAndStore(sql_1);
                nombre = queryProducto.getDataAsStringNotNull(0, "nombre");
                inventario = Integer.parseInt(queryProducto.getDataAsStringNotNull(0, "inventario"));
            }catch(Exception e){
            } 
        }
        if(idAccion==1){
            titulo = "Nuevo producto";
        }
        if(idAccion==2){
            titulo = "Entrada de inventario";
        }
        if(idAccion==3){
            titulo = "Salida de inventario";
        }
        if(idAccion==4){
            titulo = "Baja de producto";
        }
        if(idAccion==5){
            titulo = "Reactivar producto";
        }

%>
<jsp:include page="/app/jsp/yield/head.jsp"/>
<jsp:include page="/app/jsp/yield/header.jsp"/>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/app/jsp/yield/sidebar.jsp"/>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2"><%=titulo%></h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                </div>
            </div>
            <div>
                <div class="card col-sm-12 col-md-6 col-lg-4">
                    <div class="card-body">
                        <form id="producto" method="post">
                            <div class="form-control">
                                <input type="hidden" name="idProducto" value="<%=idProducto%>" class="">
                                <input type="hidden" name="idAccion" value="<%=idAccion%>" class="">
                                <label>Nombre de Producto</label>
                                <input type="text" name="nombre" value="<%=nombre%>" class="form-control rounded-0" <%= idAccion == 4 || idAccion == 5? "disabled" : ""%>>                                
                                <label>Inventario</label>
                                <input type="text" name="inventario" value="<%=inventario%>" class="form-control rounded-0" <%= idAccion == 2 || idAccion == 3? "" : "disabled"%>>
                                <input type="hidden" name="inventario_anterior" value="<%=inventario%>">
                            </div>
                        </form>
                    </div>
                    <div class="card-footer d-flex gap-2 justify-content-end" id="btn-container">
                        <button class="btn btn-primary" onclick="modificar()">Guardar<span id="btn-spinner" style="display: none;">&nbsp;&nbsp;<i class="spinner-border spinner-border-sm"></i></span></button>
                        <button class="btn btn-danger" onclick="goBack()">Salir</button>
                    </div>
                </div>                
            </div>
        </main>
    </div>
</div>
<script>
    function modificar() {
        $("#btn-spinner").show();
        $("#btn-container button").prop("disabled", true);
        $.ajax({
            url: "/ejercicio1/app/jsp/inventario/inventarioControlador.jsp",
            method: "post",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: $("#producto").serializeArray(),
            success: function (result) {
                if (result.estatus == 'exito') {
                    $("#btn-spinner").hide();
                    Swal.fire({
                        icon: 'success',
                        title: 'Cambios Guardados',
                        confirmButtonText: 'Volver'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            goBack();
                        }
                    });
                } else {
                    $("#btn-container button").prop("disabled", false);
                    $("#btn-spinner").hide();
                    Swal.fire({
                        icon: 'error',
                        title: result.msg,
                        confirmButtonText: 'Salir'
                    });
                }
            }
        });
    }
    function goBack() {
        location.href = "/ejercicio1/app/jsp/inventario/inventarioLista.jsp";
    }
    function reload() {
        location.reload(true);
    }
</script>
<jsp:include page="/app/jsp/js/js.jsp"/>
<jsp:include page="/app/jsp/yield/footer.jsp"/>
<%
    }
%>