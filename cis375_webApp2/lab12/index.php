<?php

//Simple mail function with HTML header
function sendmail($to, $subject, $message, $from) {
    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type:text/html;charset=iso-8859-1" . "\r\n";
    $headers .= 'From: ' . $from . "\r\n";
    $result = mail($to, $subject, $message, $headers);
    return $result;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Email Example</title>
    <link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="styles/styles.css">
</head>
<body>
<div class="col-sm-6 col-sm-offset-3">
    <div id="emaildiv">
        <h2>Email Form</h2>
        <form class="form-horizontal" role="form" method="post" action=".">
            <div class="form-group">
                <label for="name" class="control-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="First &amp; Last Name" autofocus>
            </div>
            <div class="form-group">
                <label for="email" class="control-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com">
            </div>
            <div class="form-group">
                <label for="comment" class="control-label">Comment</label>
                <textarea class="form-control" rows="4" name="comment" id="comment"></textarea>
            </div>
            <div class="form-group">
                <input id="submit" name="submit" type="submit" value="Send Email" class="btn btn-primary">
                <input id="reset" type="button" value="Reset" onClick="location.href=location.href" class="btn btn-primary">
            </div>
        </form>
    </div>
    <div id="done">
        <?php if ($result) {
            echo '<img alt="Success" src="styles/check.png"><h3>Email Successfully Sent</h3>';
            echo '<p>Thank you, <strong>' . $name . '</strong>, for your email.</p>';
            echo '<table class="table table-bordered table-striped table-hover table-nonfluid">';
            echo '<tr><th>Name:</th><td>' . $name . '</td></tr>';
            echo '<tr><th>Email:</th><td>' . $email . '</td></tr>';
            echo '<tr><th>Comment:</th><td>' . $comment . '</td></tr>';
            echo '</table>';
        } ?>
    </div>
</div>
</body>
</html>