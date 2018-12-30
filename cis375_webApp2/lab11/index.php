<?php
require_once 'database.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim(filter_input(INPUT_POST, 'username'));
    $password = trim(filter_input(INPUT_POST, 'password'));

    if (empty($username)) $error_username = 'Please enter your username.';
    if (empty($password)) $error_password = 'Please enter your password.';

    if (empty($error_username) && empty($error_password)) {
        // set $sql equal to a query that retrieves the username and password fields
        // from the table where username field is equal to a bound parameter
        $sql = "";
        if ($statement = $db->prepare($sql)) {
            $statement->bindParam(':username', $username);
            if ($statement->execute()) {
                // Check if username exists, if yes then verify password
                if ($statement->rowCount() == 1) {
                    if ($row = $statement->fetch()) {
                        // set a new variable that will hold a hashed password equal to
                        // $row['the name of the password field'];

                        // use the password_verify() function to check if the variable that holds
                        // the hashed password is the same as the $password variable
                        if ($password) {
                            // start a new session and save the username as a session variable


                            // redirect user to the welcome page

                        } else {
                            $error_password = 'The password you entered was not valid.';
                        }
                    }
                } else {
                    // Display an error message if the username is not found in the table
                    $error_username = 'No account found with that username.';
                }
            } else {
                echo "An error occurred. Please try again.";
            }
        }
        unset($statement);
    }
    unset($db);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="style/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="style/styles.css" type="text/css">
</head>
<body>
<div class="wrapper">
    <h2>Login</h2>
    <p>Please fill in your credentials to login.</p>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <div class="form-group <?php echo (!empty($error_username)) ? 'has-error' : ''; ?>">
            <label for="username">Username:<sup>*</sup></label>
            <input type="text" name="username" id="username" class="form-control"
                   value="<?php if(!empty(filter_input(INPUT_POST, 'username'))) echo filter_input(INPUT_POST, 'username'); ?>"
                   autofocus>
            <span class="help-block"><?php if(!empty($error_username)) echo $error_username; ?></span>
        </div>
        <div class="form-group <?php echo (!empty($error_password)) ? 'has-error' : ''; ?>">
            <label for="password">Password:<sup>*</sup></label>
            <input type="password" name="password" id="password" class="form-control"
                   value="<?php if(!empty(filter_input(INPUT_POST, 'password'))) echo filter_input(INPUT_POST, 'password'); ?>">
            <span class="help-block"><?php if(!empty($error_password)) echo $error_password; ?></span>
        </div>
        <div class="form-group">
            <input type="submit" class="btn btn-primary" value="Submit">
        </div>
        <p>Don't have an account? <a href="register.php">Sign up now</a>.</p>
        <p><sup>*</sup> Indicates a required field.</p>
    </form>
</div>
</body>
</html>
