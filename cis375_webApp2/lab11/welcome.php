<?php
// Initialize the session

// If the session variable is not set or is empty, redirect to the login page and exit

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="style/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="style/styles.css" type="text/css">
</head>
<body>
<div class="wrapper page-header">
    <!-- display the username session variable in the greeting below -->
    <h1>Hello, <strong><?php ?></strong>.</h1>
    <p>Welcome to the restricted area of the website.</p>
    <p><a href="logout.php" class="btn btn-danger">Log out</a></p>
</div>
</body>
</html>