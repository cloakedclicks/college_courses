<?php

include 'functions.php';

$games = array();
$total = 0;

// load values into array
if (!empty(filter_input(INPUT_POST, 'game1'))) $games[0] = filter_input(INPUT_POST, 'game1');
if (!empty(filter_input(INPUT_POST, 'game2'))) $games[1] = filter_input(INPUT_POST, 'game2');
if (!empty(filter_input(INPUT_POST, 'game3'))) $games[2] = filter_input(INPUT_POST, 'game3');

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Array Help</title>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById('game1').focus();
            document.getElementById('game1').select();
        }
    </script>
    <style type="text/css">
        input[type="text"] {
            width: 4em;
            text-align: right;
        }
    </style>
<body>
<h3>Bowling Scores - <?php echo date('l, m/d/y'); ?></h3>
<form action="." method="post">
    <label for="game1">Game 1:</label>
    <input type="text" name="game1" id="game1" value="<?php if(!empty($games[0])) echo $games[0]; ?>"><br>
    <label for="game2">Game 2:</label>
    <input type="text" name="game2" id="game2" value="<?php if(!empty($games[1])) echo $games[1]; ?>"><br>
    <label for="game3">Game 3:</label>
    <input type="text" name="game3" id="game3" value="<?php if(!empty($games[2])) echo $games[2]; ?>"><br>
    <p><input type="submit" value="Find Average"></p>
</form>
<?php
if(count($games) == 3) {
    echo '<h3>Scores</h3>';
    echo '<ul>';
    for ($arrayIndex = 0; $arrayIndex < 3; $arrayIndex++) {
        echo '<li>' . $games[$arrayIndex] . ' - Rank: ' . getRank($games[$arrayIndex]) . '</li>';
        $total += $games[$arrayIndex];
    }
    echo '</ul>';
    echo '<h3>Average</h3>';
    $average = $total / 3;
    echo '<p>' . number_format($average, 2) . '</p>';
    echo '<h3>Rank</h3>';
    echo '<p>' . getRank($average) . '</p>';
} else {
    echo '<h3>Please enter bowling scores in all 3 textboxes</h3>';
}
?>

</body>
</html>
