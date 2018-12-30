<?php
$dsn = 'mysql:host=localhost;dbname=dsuclass_lanier2';
$username = 'dsuclass_lanier2';
$password = 'dsuclass_lanier2';

try {
    $db = new PDO($dsn, $username, $password);
} catch (PDOException $e) {
    $error_message = $e->getMessage();
    echo '<p>' . $error_message . '</p>';
}
$query = 'SELECT * FROM employees ORDER BY fullName';
$statement = $db->prepare($query);
$statement->execute();
$employees = $statement->fetchAll();
$statement->closeCursor();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LaNer - Lab 5</title>
    <link rel="stylesheet" href="bootstrap.min.css">
</head>
<body>
<div class="container table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <caption>Employee List - <?php echo date('m/d/Y'); ?></caption>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>Age</th>
            <th>Username</th>
            <th>Phone</th>
        </tr>
        <?php foreach ($employees as $employee) : ?>
            <?php
            // assign the values from the database table fields to variables
            $full_name = $employee['fullName'];
            $date_of_birth = new DateTime($employee['birthDate']);
            $phone = $employee['phoneNumber'];

            // find the index or position of the space between the names
            $i = strpos($full_name, ', ');

            // the first name starts at index 0 and uses $i as the length because the index number matches
            // the number of characters before the comma
            $first_name = substr($full_name, $i + 2);
            // the last name starts at 2 character after the comma and goes to the end of the string
            $last_name = substr($full_name, 0, $i);

            // the date format below uses no leading zeros for the month and day
            $formattedDateOfBirth = $date_of_birth->format('M d, Y');

            // calculate the age using the date_diff() function to find the number of years between
            // the date of birth and the current date
            $age = date_diff($date_of_birth, date_create(date('Y-m-d')))->format('%y');

            // the username is the complete last name followed by the first character of the first name
            // using something similar to the $first_name $last_name code starting at line 47 adding
            // concatenation of the two names
            $username = strtolower(substr($full_name, 0, $i) . substr($full_name, $i + 2, 1));

            // format the phone number to (605) 256-5555 format using substr() and concatenation
            $formattedPhone = '(' . substr($phone, 0, 3) . ')' . ' ' . substr($phone, 3, 3) . '-' . substr($phone, 6);

            ?>
            <tr>
                <td><?php echo $first_name; ?></td>
                <td><?php echo $last_name; ?></td>
                <td><?php echo $formattedDateOfBirth; ?></td>
                <td><?php echo $age; ?></td>
                <td><?php echo $username; ?></td>
                <td><?php echo $formattedPhone; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>

</div>
</body>
</html>
