<?php
require 'model/database.php';
require 'model/watches_db.php';

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else if (isset($_GET['action'])) {
    $action = $_GET['action'];
} else {
    $action = 'list-watches';
}

if($action == 'list-watches') {
    $watches = getWatches();
    include 'view/watches_list.php';
}