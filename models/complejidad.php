<?php

require_once 'conexion.php';

class Complejidad extends Conexion{
    private $acceso;

    public function __CONSTRUCT(){
        $this->acceso = parent::getConexion();
    }

    public function listarComplejidades(){
        try{
            $consulta = $this->acceso->prepare("CALL spu_complejidad_listar()");
            $consulta->execute();

            return $consulta->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Excepcion $e){
            die($e->getMessage());
        }
    }
}

?>