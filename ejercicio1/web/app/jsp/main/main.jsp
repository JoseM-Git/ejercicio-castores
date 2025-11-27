<%-- 
    Document   : main
    Created on : 25 nov 2025, 10:15:28 p.m.
    Author     : josem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />
<%
if (usuario.getID()== 0) {
        response.sendRedirect("/ejercicio1/app/jsp/login/login.jsp");
        response.flushBuffer();
}else{
  
%>
   

<jsp:include page="/app/jsp/yield/head.jsp"/>
<jsp:include page="/app/jsp/yield/header.jsp"/>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/app/jsp/yield/sidebar.jsp"/>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Inicio</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">
                            Compartir
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">
                            Exportar
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/app/jsp/js/js.jsp"/>
<jsp:include page="/app/jsp/yield/footer.jsp"/>

<%
    }
%>