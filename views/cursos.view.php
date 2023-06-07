<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>cursos</title>

    <!-- Estilos de bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <!-- datatable  CSS-->
    <link hret="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css">
    <link href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css" rel="stylesheet">

</head>
<body>
    <style>
        .bold{
            font-weight: bold;
        }
    </style>
    <div class="container mt-4">
        <center><h2>Cursos</h2></center>
        <hr>
        <div class="mb-3">
            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#modal-registro-cursos" id="abrir-modal-registro">
                <i class = "fa-sharp fa-solid fa-file"></i> Nuevo Curso
            </button>
            <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modal-busqueda-cursos" id="abrir-modal-busqueda">
                <i class = "fa-sharp fa-solid fa-magnifying-glass"></i> Buscar curso
            </button>
        </div>
        <table class="table table-striped mt-4" id="tabla-cursos">
            <colgroup>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
            </colgroup>
        <thead class = "table-info">
            <tr>
                <th>#</th>
                <th>Apellidos</th>
                <th>Nombres</th>
                <th>especialidad</th>
                <th>Sede</th>
                <th>Titulo</th>
                <th>Descripcion</th>
                <th>Fecha inicio</th>
                <th>Complejidad</th>
                <th>Precio</th>
                <th>comandos</th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    </div>
    <!-- Primer modal: REGISTRO DE CURSOS -->
    <div class="modal fade" id="modal-registro-cursos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
            <div class="modal-content">
                <div id="modal-registro-header" class="modal-header bg-danger text-light">
                    <h5 class="modal-title" id="modal-registro-titulo">Registro de Cursos</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" autocomplete="off" id="formulario-cursos" >
                        <div>
                            <label for="profesores" class="form-label bold">Profesor:</label>
                            <select name="profesores" id="profesores" class="form-select">
                                <option value="">Seleccione</option>
                            </select>
                        </div>
                        <div>
                            <label for="sedes" class="form-label bold">Sede:</label>
                            <select name="sedes" id="sedes" class="form-select">
                                <option value="">Seleccione</option>
                            </select>
                        </div>
                        <div class="mt-3">
                            <label for="titulo" class="form-label bold">Titulo:</label>
                            <input type="text" class="form-control form-control-sm" id="titulo" >
                        </div>
                        <div class="mt-3">
                            <label for="descripcion" class="form-label">Descripción:</label>
                            <input type="text" class="form-control form-control-sm" id="descripcion" placeholder="Campo opcional">
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mt-3">
                                <label for="inicio" class="form-label bold">Inicio:</label>
                                <input type="datetime-local" class="form-control form-control-sm" id="inicio" maxlength="8">
                            </div>
                            <div>
                                <label for="complejidad" class="form-label bold">Complejidad:</label>
                                <select name="complejidad" id="complejidad" class="form-select">
                                    <option value="">Seleccione</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-3">
                            <label for="precio" class="form-label bold">Precio:</label>
                            <input type="email" class="form-control form-control-sm" id="precio">
                        </div>
                        
                    </form> 
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-sm btn-danger" id="guardar">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <!--Js Bootstrap 5.2-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    
    <!-- AJAX = JavaScript asincrónico-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- Fontawesome -->
    <script src="https://kit.fontawesome.com/2927838564.js" crossorigin="anonymous"></script>
    
    
    <script src = "https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src = "https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function (){
            function mostrarcursos(){
                $.ajax({
                    url: '../controllers/curso.controller.php',
                    type: 'GET',
                    data: {'operacion':'listarCursos'},
                    success: function (result){
                        var tabla = $("#tabla-cursos").DataTable();

                        tabla.destroy();

                        $("#tabla-cursos tbody").html(result);

                        $("#tabla-cursos").DataTable({
                            lenguage: {
                                url: 'js/Spanish.json'
                            },
                            dom:'Bfrtip',
                            buttons: [
                                {
                                    extend:'print',
                                    exportOptions: {columns: [0,1,2,3,4,5,6,7,8,9,10,11]}
                                }
                            ]
                        });
                    }
                })
            }
            function mostrarProfesores(){
                $.ajax({
                    url: '../controllers/profesor.controller.php',
                    type: 'GET',
                    data: {'operacion': 'listarProfesores'},
                    success: function (result){
                        $("#profesores").html(result);
                    }
                });
            }
            function mostrarSedes(){
                $.ajax({
                    url: '../controllers/sede.controller.php',
                    type: 'GET',
                    data: {'operacion':'listarSedes'},
                    success: function(result){
                        $('#sedes').html(result);
                    }
                });
            }
            function mostrarComplejidad(){
                $.ajax({
                    url: '../controllers/complejidad.controller.php',
                    type: 'GET',
                    data: {'operacion' : 'listarComplejidades'},
                    success: function (result){
                        $('#complejidad').html(result);
                    }
                });
            }
            function RegistrarCursos(){
                let datosEnviar = {
                    'operacion' : 'insertarcurso',
                    'idprofesor'    : $("#profesores").val,
                    'idsede'        : $("#sedes").val,
                    

                }
            }
            mostrarcursos();
            mostrarProfesores();
            mostrarSedes();
            mostrarComplejidad();
        });
    </script>
</body>
</html>