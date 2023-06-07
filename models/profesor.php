<?php
require_once 'conexion.php';

class Profesor extends Conexion{
    private $acceso;

    public function __CONSTRUCT(){
        $this->acceso = parent::getConexion();
    }

    public function listarProfesores(){
        try{
            $consulta = $this->acceso->prepare("CALL spu_profesores_listar()");
            $consulta->execute();

            return $consulta->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }
}


?>