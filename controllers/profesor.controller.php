<?php

require_once "../models/profesor.php";

if(isset($_GET['operacion'])){
    $profesor = new Profesor();

    if($_GET['operacion'] == 'listarProfesores'){
        $data = $profesor->listarProfesores();

        if($data){
            echo "<option value='' selected>Seleccione</option>";
            foreach($data as $registro){
                echo "<option value='{$registro['idprofesor']}'>{$registro['nombres']}, {$registro['apellidos']} - {$registro['especialidad']}</option>";
            }

        }
    }
}

?>