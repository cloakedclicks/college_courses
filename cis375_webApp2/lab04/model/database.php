<?php
$dsn = 'mysql:host=localhost;dbname=dsuclass_lanier2';
$username = 'dsuclass_lanier2';
$password = 'dsuclass_lanier2';

try {
    $db = new PDO($dsn, $username, $password);
} catch (PDOException $e) {
    $error_message = $e->getMessage();
    include 'view/header.php';
    echo '<h1>Error</h1>h1>';
    echo '<p>' . $error_message . '</p>';
    include 'view/footer.php';
    exit();
}