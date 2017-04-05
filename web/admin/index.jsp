<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 
    Document   : index
    Created on : 29-mar-2017, 20:57:12
    Author     : Carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <title>Adminstrador del Sistema</title>
        <script>

            function enviarModal(codigo, nombres, apellidos, sueldo) {
                //    alert("codigo: "+codigo+" nombres: "+nombres); 
                document.getElementById('codigo').value = codigo;
                document.getElementById('nombre').value = nombres;
                document.getElementById('apellido').value = apellidos;
                document.getElementById('sueldo').value = sueldo;


            }

            function link() {
                var url = "persona?action=actualizar";
                return url;
            }

        </script>

        <script>

            $(document).ready(function () {
                document.getElementById("load").style.visibility = "hidden";
                document.getElementById("myAnchor").focus();
            });





        </script>
        <script>



            function pasarVariables(pagina, param, valor) {
                pagina += "?action=actualizar&";
                paramVec = param.split(",");
                valorVec = valor.split(",");
                for (i = 0; i < paramVec.length; i++)
                    pagina += paramVec[i] + "=" + escape(eval(valorVec[i])) + "&";
                pagina = pagina.substring(0, pagina.length - 1);
                location.href = pagina;
            }

            function actualizarPersona() {
                document.getElementById("load").style.visibility = "visible";

                var nombre = document.getElementById("nombre").value;
                var apellido = document.getElementById("apellido").value;
                var codigo = document.getElementById("codigo").value;
                var sueldo = document.getElementById("sueldo").value;

                var statusConfirm = confirm("¿Desea Actualizar los Datos de la Persona?");
                if (statusConfirm == true)
                {
                    ////////////////////////////////////////////////////////////


                    var pagina = "persona?action=actualizar&codigo=" +
                            codigo + "&nombres=" + nombre + "&apellidos=" +
                            apellido + "&sueldo=" + sueldo;

                    //  alert(nombre + apellido + codigo + sueldo);
                    location.href = pagina;
                }
                document.getElementById("load").style.visibility = "hidden";

            }

            ///////////////////////////////////////////////////////////////////
            function eliminarPersona(codigo) {
                document.getElementById("load").style.visibility = "visible";

                var statusConfirm = confirm("¿Desea Eliminar registro de Persona?");
                if (statusConfirm == true)
                {
                    var pagina = "persona?action=eliminar&cod=" + codigo;
                    location.href = pagina;

                }
                document.getElementById("load").style.visibility = "hidden";

            }

        </script>
        <style>
            #panel{
                margin-top: 3%;
                width: 80%;
            }

            #mySidenav a {
                position: absolute;
                left: -100px;
                transition: 0.3s;
                padding: 15px;
                width: 120px;
                text-decoration: none;
                font-size: 20px;
                color: white;
                border-radius: 0 5px 5px 0;
            }

            #mySidenav a:hover {
                left: 0;
            }

            #about {
                top: 20px;
                background-color: #2196F3;
            }

            #blog {
                top: 80px;
                background-color: #2196F3;
            }

            #projects {
                top: 140px;
                background-color: #2196F3;
            }

            #contact {
                top: 200px;
                background-color: #2196F3;
            }
            
            #bienvenido{
                text-align: center;
            }

        </style>
    </head>
    <body>
        <META HTTP-EQUIV="refresh" 
              CONTENT="<%= session.getMaxInactiveInterval() %>;
              URL=./inicio" />
        <div id="mySidenav" class="sidenav">
         <c:if test="${user!=null}">
          <a href="../sitecontroller?action=salir" id="about">Salir</a>
         </c:if>
          <c:if test="${user==null}">
          <a href="inicio" id="about">Inicio</a>
         </c:if>
          <a href="#" id="blog">Blog</a>
            <a href="#" id="projects">Ingresar</a>
            <a href="#" id="contact">Contacto</a>
        </div>


        <c:if test="${user!=null}">

            <h1 id="bienvenido">Bienvenido ${user}</h1><br/>

        </c:if>


        <img id="load" src="./img/ajax-loader.gif" alt="load" height="32" width="32"> 
    <center>
        <div id="panel" class="panel panel-default">
            <div class="panel-body">

                <c:if test="${tam==0}">
                    <div class="alert alert-warning">
                        <strong>Mensaje!</strong> 
                        No Existe Registro en la Tabla Persona
                    </div>
                </c:if>
                <c:if test="${tam>0}">

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Sueldo</th> 
                                    <c:if test="${user!=null}">

                                    <th>Accion</th>
                                    </c:if>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${lista}" var="pers" varStatus="status">


                                <tr>
                                    <td>${pers.codigo}</td>
                                    <td>${pers.nombres}</td>
                                    <td>${pers.apellidos}</td>
                                    <td>${pers.sueldo}</td>
                                    <c:if test="${user!=null}">

                                        <td>

                                            <button class="btn btn-warning" data-toggle="modal" data-target="#myModal" onclick="enviarModal('${pers.codigo}', '${pers.nombres}', '${pers.apellidos}', '${pers.sueldo}')">Actualizar</button>
                                           <!-- <a class="btn btn-danger" href="persona?action=eliminar&cod=${pers.codCif}" role="button">Eliminar</a>-->
                                            <a class="btn btn-danger" onclick="javascript:eliminarPersona('${pers.codCif}')"  role="button">Eliminar</a>

                                        </td>
                                    </c:if>
                                </tr>

                            </c:forEach>

                        </tbody>
                    </table>

                    <!------------------------------------>

                    <!-- Modal -->
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Actualizar Persona</h4>
                                </div>
                                <div class="modal-body">


                                    <div class="form-group">
                                        <label for="codigo">Codigo:</label>
                                        <input type="text"  class="form-control" id="codigo" 
                                               readonly>
                                        <label for="nombre">Nombres:</label>
                                        <input type="text" class="form-control" id="nombre">
                                        <label for="apellido">Apellidos:</label>
                                        <input type="text" class="form-control" id="apellido">
                                        <label for="sueldo">sueldo:</label>
                                        <input type="text" class="form-control" id="sueldo">

                                    </div>
                                    <a class="btn btn-success" onclick="javascript:actualizarPersona()"  role="button">Actualizar</a>

                                </div>
                                <div class="modal-footer">
                                    <button type="button"  class="btn btn-default" data-dismiss="modal" href="./persona?action=lista">Cerrar</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:if>
            </div>
            <br/>
            <br/>
            <br/>
        </div>
    </center>
</body>
</html>
