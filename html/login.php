<!DOCTYPE html>
<!--   
  - Created on:    Ago-2016
  - Author:        A. Contreras <amaruhca@gmail.com>
-->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - tpv</title>
        <link rel="stylesheet" type="text/css" href="../css/general.css"> 
    </head>
    <body>
        <?php
            include '../php/errores.php';
            $user = $_REQUEST['user'];
            $pass = $_REQUEST['pass'];
?> <?php
            if ($user == NULL) {
                $campo = 'Usuario';
                nulos($campo);
            }
            
            if ($pass == NULL) {
                $campo = 'Contraseña';
                nulos($campo);
            }

        ?>
    </body>
</html>
