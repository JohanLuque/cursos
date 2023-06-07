<?php

class Conexion{

    protected $pdo;

    public function Conectar(){
        $conexion = new PDO("mysql:host=localhost;port=3306;dbname=instituto;charset=utf8", "root", "");
        return $conexion;
    }

    public function getConexion(){
        try{
            $pdo = $this->Conectar();

            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $pdo;
        }
        catch(Exception $e)
        {
            die($e->getMessage());
        }
    }
}

?>