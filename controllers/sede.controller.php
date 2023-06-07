<?php

require_once '../models/sede.php';

if(isset($_GET['operacion'])){
    $sede = new Sede();
    if($_GET['operacion'] == 'listarSedes'){
        $data = $sede->listarSedes();

        if($data){
            echo "<option value='' selected>Seleccione</option>";
            foreach($data as $registro){
                echo "<option value='{$registro['idsede']}'>{$registro['nombresede']}</option>";
            }
        }
    }
}

?>