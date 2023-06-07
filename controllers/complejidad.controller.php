<?php

require_once '../models/complejidad.php';

if(isset($_GET['operacion'])){
    $complejidad = new Complejidad();

    if($_GET['operacion'] == 'listarComplejidades'){
        $data = $complejidad->listarComplejidades();
        if($data){
            echo "<option value='' selected>Seleccione</option>";
            foreach($data as $registro){
                echo "<option value= '{$registro['idcomplejidad']}'>{$registro['complejidad']}</option>";
            }
        }
    }

}

?>