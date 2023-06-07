<?php

require_once '../models/curso.php';

if (isset($_GET['operacion'])){
    $curso = new Curso();
    if ($_GET['operacion'] == 'listarCursos'){
        $data = $curso->listarCursos();
        if($data){

            foreach($data as $registro){
                echo "
                    <tr>
                        <td>{$registro['idcurso']}</td>
                        <td>{$registro['apellidos']}</td>
                        <td>{$registro['nombres']}</td>
                        <td>{$registro['especialidad']}</td>
                        <td>{$registro['nombresede']}</td>
                        <td>{$registro['titulo']}</td>
                        <td>{$registro['descripcion']}</td>
                        <td>{$registro['fechainicio']}</td>
                        <td>{$registro['complejidad']}</td>
                        <td>{$registro['precio']}</td>
                        <td>
                            <a href='#' data-ideliminar='{$registro['idcurso']}' class='btn btn-sm btn-danger eliminar'><i class='fa-solid fa-trash'></i></a>
                            <a href='#' data-ideditar='{$registro['idcurso']}' class='btn btn-sm btn-info editar'><i class='fa-solid fa-pencil'></i></a>
                        </td>
                    </tr>
                ";
            }
        }
    }
    
    if($_GET['operacion'] == 'insertarcurso'){
        $datos = [
            "idprofesor"    =>$_GET['idprofesor'],
            "idsede"        =>$_GET['idsede'],
            "titulo"        =>$_GET['titulo'],
            "descripcion"   =>$_GET['descripcion'],
            "fechainicio"   =>$_GET['fechainicio'],
            "idcomplejidad"   =>$_GET['idcomplejidad'],
            "precio"        =>$_GET['precio']

        ];

        $curso->insertarCurso($datos);
    }

    if($_GET['operacion'] == 'actualizarCurso'){
        $datos = [
            "idcurso"       =>$_GET['idcurso'],
            "idprofesor"    =>$_GET['idprofesor'],
            "idsede"        =>$_GET['idsede'],
            "titulo"        =>$_GET['titulo'],
            "descripcion"   =>$_GET['descripcion'],
            "fechainicio"   =>$_GET['fechainicio'],
            "idcomplejidad"   =>$_GET['idcomplejidad'],
            "precio"        =>$_GET['precio']

        ];
        $curso->actualizarCurso($datos);
    }
    if($_GET['operacion'] == 'eliminarCurso'){
        $curso->eliminarCurso($_GET['idcurso']);
    }
    if($_GET['operacion'] == 'obtenerdatos'){
        $data = $curso->obtenerdatos($_GET['idcurso']);
        echo json_encode($data);
    }
    if($_GET['operacion'] == 'buscarCurso'){
        $data = $curso->buscarCurso($_GET['idcurso']);
        echo json_encode($data);
    }

}



?>