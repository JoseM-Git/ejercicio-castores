<%-- 
    Document   : login
    Created on : 26 nov 2025, 11:04:46 a.m.
    Author     : josem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><!doctype html>
<%@page import="com.ejercicio1.backend.usuarioBL"%>

<jsp:useBean id="usuario" scope="session" class="com.ejercicio1.backend.usuarioBL" />

<%
if (usuario != null && usuario.getID() > 0) {
        response.sendRedirect("/ejercicio1/app/jsp/main/main.jsp");
        response.flushBuffer();
 }
%>
<html lang="en" data-bs-theme="auto">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="" />
        <meta
            name="author"
            content="Mark Otto, Jacob Thornton, and Bootstrap contributors"
            />
        <meta name="generator" content="Astro v5.13.2" />
        <title>Iniciar Sesión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <meta name="theme-color" content="#712cf9" />
        <link href="sign-in.css" rel="stylesheet" />
        <style>
          .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
          }
          @media (min-width: 768px) {
            .bd-placeholder-img-lg {
              font-size: 3.5rem;
            }
          }
          .b-example-divider {
            width: 100%;
            height: 3rem;
            background-color: #0000001a;
            border: solid rgba(0, 0, 0, 0.15);
            border-width: 1px 0;
            box-shadow:
              inset 0 0.5em 1.5em #0000001a,
              inset 0 0.125em 0.5em #00000026;
          }
          .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
          }
          .bi {
            vertical-align: -0.125em;
            fill: currentColor;
          }
          .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
          }
          .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
          }
          .btn-bd-primary {
            --bd-violet-bg: #712cf9;
            --bd-violet-rgb: 112.520718, 44.062154, 249.437846;
            --bs-btn-font-weight: 600;
            --bs-btn-color: var(--bs-white);
            --bs-btn-bg: var(--bd-violet-bg);
            --bs-btn-border-color: var(--bd-violet-bg);
            --bs-btn-hover-color: var(--bs-white);
            --bs-btn-hover-bg: #6528e0;
            --bs-btn-hover-border-color: #6528e0;
            --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
            --bs-btn-active-color: var(--bs-btn-hover-color);
            --bs-btn-active-bg: #5a23c8;
            --bs-btn-active-border-color: #5a23c8;
          }
          .bd-mode-toggle {
            z-index: 1500;
          }
          .bd-mode-toggle .bi {
            width: 1em;
            height: 1em;
          }
          .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
          }
          html,
          body {
              height: 100%;
          }

          .form-signin {
              max-width: 330px;
              padding: 1rem;
          }

          .form-signin .form-floating:focus-within {
              z-index: 2;
          }

          .form-signin input[type="email"] {
              margin-bottom: -1px;
              border-bottom-right-radius: 0;
              border-bottom-left-radius: 0;
          }

          .form-signin input[type="password"] {
              margin-bottom: 10px;
              border-top-left-radius: 0;
              border-top-right-radius: 0;
          }

        </style>
    </head>
    <body class="d-flex align-items-center py-4 bg-body-tertiary">
        
    <main class="form-signin w-100 m-auto">
        <form id="login">
            <h1 class="h3 mb-3 fw-normal">Iniciar Sesión</h1>
            <div class="form-floating">
                <input
                    type="email"
                    class="form-control"
                    id="floatingInput"
                    placeholder="name@example.com"
                    name="email"
                    />
                <label for="floatingInput">Usuario</label>
            </div>
            <div class="form-floating">
                <input
                    type="password"
                    class="form-control"
                    id="floatingPassword"
                    placeholder="Password"
                    name="pwd"
                    />
                <label for="floatingPassword">Contraseña</label>
            </div>
        </form>
        <button class="btn btn-primary w-100 py-2" id="login_btn" onclick="login()">
            Iniciar sesión
        </button>
        <p class="mt-5 mb-3 text-body-secondary">Ejercicio de prueba 2025</p>
        <div class="w-100" style="">
            <div class="alert alert-danger rounded-0 border-0 border-start border-danger text-start w-100" id="login-response" style="display:none"></div>
        </div>
    </main>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script>
        function login() {
            $("#login_btn").prop("disabled", true);
            $.ajax({
                url: "/ejercicio1/app/jsp/login/validarLogin.jsp",
                method: "post",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: $("#login").serializeArray(),
                success: function (result) {
                    if(result.estatus == 'exito'){
                        location.reload();
                    } else{
                        $("#login-response").empty();
                        $("#login-response").append("<h6 class=\"m-0\"><b>"+result.msg+"</b></h6>");
                        $("#login-response").slideToggle(250, function(){
                            setTimeout(function(){
                                $("#login-response").fadeToggle(500, function(){
                                    $("#login-response").empty();
                                });
                                $("#login_btn").prop("disabled", false);
                            }, 2500);
                        });
                    }
                }
            });
        }
        function reload() {
            location.reload(true);
        }
    </script>
</body>
</html>
