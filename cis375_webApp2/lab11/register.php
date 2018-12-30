<?php
require_once 'database.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim(filter_input(INPUT_POST, 'username'));
    $password = trim(filter_input(INPUT_POST, 'password'));
    $password2 = trim(filter_input(INPUT_POST, 'confirm_password'));

    if (empty($username)) {
        $error_username = "Please enter a username.";
    } else {
        // set $sql equal to a query that retrieves the id field from 
        // the table where the username field is equal to a bound parameter :username
        $sql = "";
        if ($statement = $db->prepare($sql)) {
            $statement->bindParam(':username', $username);
            if ($statement->execute()) {
                if ($statement->rowCount() == 1) {
                    $error_username = "The username you entered is already taken.";
                }
            } else {
                echo "An error occurred. Please try again.";
            }
        }
        unset($statement);
    }
    if (empty($password)) {
        $error_password = "Please enter a password.";
    } elseif (strlen($password) < 8) {
        $error_password = "Password must have at least 8 characters.";
    } // this is an ideal location to enforce other password complexity policies
    if (empty($password2)) {
        $error_password_confirmation = 'Please confirm the password.';
    } else {
        if ($password != $password2) {
            $error_password_confirmation = 'The passwords you entered did not match.';
        }
    }

    if (empty($error_username) && empty($error_password) && empty($error_password_confirmation)) {
        // set a variable that stores the users IP address equal to $_SERVER['REMOTE_ADDR'];

        // set $sql equal to a query that inserts into your table name and username, password, and
        // IP address fields (whatever you named them) values that are equal to named bound parameters
        // that represent the username, password, and user's IP address
        // note - the id field is auto-incremented and the date created field is the current timestamp
        // so those fields aren't needed in the query
        $sql = "";
        if ($statement = $db->prepare($sql)) {
            // set a variable that will store the hashed password equal to the password_hash() function
            // that will hash $password using PASSWORD_DEFAULT

            // bind the 3 parameters in the query to the appropriate variables



            if ($statement->execute()) {
                header("Location: .");
            } else {
                echo "Something went wrong. Please try again later.";
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
    <title>Register Account</title>
    <link rel="stylesheet" href="style/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="style/styles.css" type="text/css">
</head>
<body>
<div class="wrapper register">
    <h2>Create Account</h2>
    <p>Please fill this form to create an account.</p>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <div class="form-group <?php echo (!empty($error_username)) ? 'has-error' : ''; ?>">
            <label for="username">Username:<sup>*</sup></label>
            <input type="text" name="username" id="username" class="form-control"
                   value="<?php if (!empty(filter_input(INPUT_POST, 'username'))) echo filter_input(INPUT_POST, 'username'); ?>"
                   autofocus>
            <span class="help-block"><?php if (!empty($error_username)) echo $error_username; ?></span>
        </div>
        <div class="form-group <?php echo (!empty($error_password)) ? 'has-error' : ''; ?>">
            <label for="password">Password:<sup>*</sup></label>
            <input type="password" name="password" id="password" class="form-control"
                   value="<?php if (!empty(filter_input(INPUT_POST, 'password'))) echo filter_input(INPUT_POST, 'password'); ?>">
            <span class="help-block"><?php if (!empty($error_password)) echo $error_password; ?></span>
        </div>
        <div class="form-group <?php echo (!empty($error_password_confirmation)) ? 'has-error' : ''; ?>">
            <label for="confirm_password">Confirm Password:<sup>*</sup></label>
            <input type="password" name="confirm_password" id="confirm_password" class="form-control"
                   value="<?php if (!empty(filter_input(INPUT_POST, 'confirm_password'))) echo filter_input(INPUT_POST, 'confirm_password'); ?>">
            <span class="help-block"><?php if (!empty($error_password_confirmation)) echo $error_password_confirmation; ?></span>
        </div>
        <div class="form-group">
            <input type="submit" class="btn btn-primary" value="Submit">
            <input type="reset" class="btn btn-default" value="Reset">
        </div>
        <p>Already have an account? <a href="index.php">Login here</a>.</p>
        <p><sup>*</sup> Indicates a required field.</p>
    </form>
</div>
</body>
</html>