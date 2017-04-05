<%-- 
    Document   : index
    Created on : 29-mar-2017, 10:26:49
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
        <title>Inicio del Sistema</title>
        <style>
            #panel{
                margin-top: 10%;
                width: 50%;
            }
            #mensaje{
                color:red;

            }
        </style>
        <script>

            $(document).ready(function () {
                document.getElementById("user").focus();
            });

            function quitarMensaje() {
                document.getElementById("mensaje").style.visibility = "hidden";

            }



        </script>
    </head>
    <body>
    <center>
        <div id="panel" class="panel panel-default">
            <div class="panel-body">
                <form method="post" action="sitecontroller">
                    <div class="form-group">
                        <label for="user">Usuario:</label>
                        <input type="user" class="form-control" id="user"
                               name="user" value="${user}" onclick="quitarMensaje()" >
                    </div>
                    <div class="form-group">
                        <label for="pwd">Contraseña:</label>
                        <input type="password" class="form-control" id="pwd"
                               name="pwd">
                    </div>
                    <p id="mensaje"> ${mensaje}<br/></p>
                    <button type="submit" class="btn btn-success">
                        Entrar
                    </button>
                    <br/>
                    <br/>
                    <a href="./admin/persona?action=lista">Lista de Persona</a>

                </form> 
            </div>
            <br/>
            <br/>
            <br/>
        </div>

    </center>
</form>
</body>
</html>
