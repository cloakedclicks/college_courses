<?php
$dsn = 'mysql:host=localhost;dbname=dsuclass_lanier2';
$username = 'dsuclass_lanier2';
$password = 'dsuclass_lanier2';

$db = new PDO($dsn, $username, $password);

$employees = $db->query('SELECT * FROM strings');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Strings Example</title>
    <link rel="stylesheet" href="bootstrap.min.css">
</head>
<body>
<div class="container table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <caption>Employee List - <?php echo date('l, F j, Y'); ?></caption>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>Age</th>
            <th>Phone Number</th>
        </tr>
        <?php foreach ($employees as $employee) : ?>
            <?php
            // assign the values from the database table fields to variables
            $full_name = $employee['fullName'];
            $date_of_birth = new DateTime($employee['birthDate']);
            $phone = $employee['phoneNumber'];

            // find the index or position of the space between the names
            $i = strpos($full_name, ' ');

            // the first name starts at index 0 and uses $i as the length because the index number matches
            // the number of characters before the space
            $first_name = substr($full_name, 0, $i);
            // the last name starts at 1 character after the space and goes to the end of the string
            $last_name = substr($full_name, $i + 1);

            // the date format below uses no leading zeros for the month and day
            $formattedDateOfBirth = $date_of_birth->format('n/j/Y');

            // calculate the age using the date_diff() function to find the number of years between
            // the date of birth and the current date
            $age = date_diff($date_of_birth, date_create(date('Y-m-d')))->format('%y');

            // formate the phone number to 605-256-5555 format using substr() and concatenation
            $formattedPhone = substr($phone, 0, 3) . '-' . substr($phone, 3, 3) . '-' . substr($phone, 6);

            ?>
            <tr>
                <td><?php echo $first_name; ?></td>
                <td><?php echo $last_name; ?></td>
                <td><?php echo $formattedDateOfBirth; ?></td>
                <td><?php echo $age; ?></td>
                <td><?php echo $formattedPhone; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</div>
</body>
</html>





