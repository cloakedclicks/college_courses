<?php

include 'functions.php';

$quizes = array();
$total = 0;

// load values into array
if (!empty(filter_input(INPUT_POST, 'quiz1'))) $quizes[0] = filter_input(INPUT_POST, 'quiz1');
if (!empty(filter_input(INPUT_POST, 'quiz2'))) $quizes[1] = filter_input(INPUT_POST, 'quiz2');
if (!empty(filter_input(INPUT_POST, 'quiz3'))) $quizes[2] = filter_input(INPUT_POST, 'quiz3');
if (!empty(filter_input(INPUT_POST, 'quiz4'))) $quizes[3] = filter_input(INPUT_POST, 'quiz4');
if (!empty(filter_input(INPUT_POST, 'quiz5'))) $quizes[4] = filter_input(INPUT_POST, 'quiz5');

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LaNier Lab06</title>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById('quiz1').focus();
            document.getElementById('quiz1').select();
        }
    </script>
    <style type="text/css">
        input[type="text"] {
            width: 4em;
            text-align: right;
        }
    </style>
<body>
<h3>Enter Quiz Scores</h3>
<form action="." method="post">
    <label for="quiz1">Quiz 1:</label>
    <input type="text" name="quiz1" id="quiz1" value="<?php if(!empty($quizes[0])) echo $quizes[0]; ?>"><br>
    <label for="quiz2">Quiz 2:</label>
    <input type="text" name="quiz2" id="quiz2" value="<?php if(!empty($quizes[1])) echo $quizes[1]; ?>"><br>
    <label for="quiz3">Quiz 3:</label>
    <input type="text" name="quiz3" id="quiz3" value="<?php if(!empty($quizes[2])) echo $quizes[2]; ?>"><br>
    <label for="quiz4">Quiz 4:</label>
    <input type="text" name="quiz4" id="quiz4" value="<?php if(!empty($quizes[3])) echo $quizes[3]; ?>"><br>
    <label for="quiz5">Quiz 5:</label>
    <input type="text" name="quiz5" id="quiz5" value="<?php if(!empty($quizes[4])) echo $quizes[4]; ?>"><br>
    <p><input type="submit" value="Find Average of 5 High Scores"></p>
</form>
<?php
if(count($quizes) == 5) {
    echo '<h3>Graded Quizzes:</h3>';
    echo '<ul>';
    for ($arrayIndex = 0; $arrayIndex < 5; $arrayIndex++) {
        echo '<li>' . $quizes[$arrayIndex] . ' - ' . getScores($quizes[$arrayIndex]) . '</li>';
        $total += $quizes[$arrayIndex];
    }
    echo '</ul>';
    echo '<h3>Quiz Average:</h3>';
    $average = $total / 5;
    echo '<p>' . number_format($average, 2) . ' ' . '% - Letter Grade:' . ' ' . getScores($average) . '</p>';
    echo '<h3>Dropped Score:</h3>';
    echo '<p>' . getScores($average) . '</p>';
} else {
    echo '<h3>Please enter scores in all textboxes.</h3>';
}
?>

</body>
</html>
