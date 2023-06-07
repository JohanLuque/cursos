<?php

require_once 'conexion.php';

class Sede extends Conexion{
    private $acceso;

    public function __CONSTRUCT(){
        $this->acceso = parent::getconexion();
    }

    public function listarSedes(){
        try{
            $consulta = $this->acceso->prepare("CALL spu_sedes_listar()");
            $consulta->execute();

            return $consulta->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }
}

?>