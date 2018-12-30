<?php
// modify the 3 lines below to include your database name, username, and password
$dsn = 'mysql:host=localhost;dbname=dsuclass_';
$username = 'dsuclass_';
$password = 'dsuclass_';

try {
    $db = new PDO($dsn, $username, $password);
} catch (PDOException $e) {
    $error_message = $e->getMessage();
    echo '<h1>Error</h1>';
    echo '<p>' . $error_message . '</p>';
    exit();
}