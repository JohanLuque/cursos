<?php

require_once 'conexion.php';

class Curso extends Conexion{
    private $acceso;

    public function __CONSTRUCT(){
        $this->acceso = parent::getConexion();
    }

    public function listarCursos(){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_listar()");
            $consulta->execute();
            $datos = $consulta->fetchAll(PDO::FETCH_ASSOC);
            return $datos;
        }
        catch(Exception $e){
            die($e->getMenssage());
        }
    }

    public function insertarCurso($datos = []){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_insertar(?,?,?,?,?,?,?)");
            $consulta->execute(
                array(
                    $datos['idprofesor'],
                    $datos['idsede'],
                    $datos['titulo'],
                    $dato['descripcion'],
                    $datos['fechainicio'],
                    $datos['idcomplejidad'],
                    $datos['precio']
                )
            );
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }

    public function actualizarCurso($datos = []){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_actualizar(?,?,?,?,?,?,?,?)");
            $consulta->execute(
                array(
                    $datos['idcurso'],
                    $datos['idprofesor'],
                    $datos['idsede'],
                    $datos['titulo'],
                    $dato['descripcion'],
                    $datos['fechainicio'],
                    $datos['idcomplejidad'],
                    $datos['precio']
                )
            );
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }
    /////////////////////////////////////////////////
    public function obtenerdatos($idcurso = 0){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_obtenerdatos(?)");
            $consulta->execute(array($idcurso));
            return $consulta->fetch(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){
            die($e->getmessage());
        }
    }
    public function buscarCurso($idcurso = 0){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_buscar(?)");
            $consulta->execute(array($idcurso));
            return $consulta->fetch(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){
            die($e->getmessage());
        }
    }

    public function eliminarCurso($idcurso = 0){
        try{
            $consulta = $this->acceso->prepare("CALL spu_cursos_eliminar(?)");
            $consulta->execute(array($idcurso));


        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }


}

?>