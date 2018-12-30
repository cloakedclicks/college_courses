<?php
    $dsn = 'mysql:host=localhost;dbname=dsuclass_lanier2';
    $username = 'dsuclass_lanier2';
    $password = 'dsuclass_lanier2';

    try {
        $db = new PDO($dsn, $username, $password);
    } catch (PDOException $e) {
        $error_message = $e->getMessage();
        include('database_error.php');
        exit();
    }
?>