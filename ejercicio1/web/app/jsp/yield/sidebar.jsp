<%-- 
    Document   : menu
    Created on : 26 nov 2025, 10:20:29 a.m.
    Author     : josem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <div style="height:100vh" class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
            <div class="offcanvas-md offcanvas-end bg-body-tertiary"
                 tabindex="-1"
                 id="sidebarMenu"
                 aria-labelledby="sidebarMenuLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="sidebarMenuLabel">Company name</h5>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="offcanvas"
                        data-bs-target="#sidebarMenu"
                        aria-label="Close"></button>
                </div>
                <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a
                                class="nav-link d-flex align-items-center gap-2 active"
                                aria-current="page"
                                href="/ejercicio1/app/jsp/main/main.jsp">
                                Inicio
                            </a>
                            <a
                                class="nav-link d-flex align-items-center gap-2 active"
                                aria-current="page"
                                href="/ejercicio1/app/jsp/inventario/inventarioLista.jsp">
                                Inventarios
                            </a>
                            <a
                                class="nav-link d-flex align-items-center gap-2 active"
                                aria-current="page"
                                href="/ejercicio1/app/jsp/login/logout.jsp">
                                Cerrar Sesión
                            </a>
                        </li>
                    </ul>    
                </div>
            </div>
        </div>