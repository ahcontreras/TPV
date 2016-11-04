<?php
/* 
 *   Created on:    Oct-2016
 *   Author:        A. Contreras <amaruhca@gmail.com>
*/

$servidor = "localhost";
$user = "root";
$pass = "19931993";
$db = "tpv";

try {
    $conexion_bd = new PDO("mysql:host=$servidor;dbname=$bd;", $user, $pass);
    // Establecer el modo de error de PDO a exepcion
    $conexion_bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    
   }
catch(PDOException $e)
    {
    print "Conecxión erronea." . $e->getMessage();
    }
    
?> 