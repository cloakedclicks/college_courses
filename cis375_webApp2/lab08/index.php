<?php
require 'model/database.php';
require 'model/watches.php';
require 'model/watches_db.php';

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else if (isset($_GET['action'])) {
    $action = $_GET['action'];
} else {
    $action = 'list-watches';
}

if($action == 'list-watches') {
    $watches = WatchesDB::getWatches();
    include 'view/watches_list.php';
} else if ($action == 'show-add-form') {
    include 'view/watches_add.php';
} else if ($action == 'add-watch') {
    $brand = filter_input(INPUT_POST, 'brand');
    $model = filter_input(INPUT_POST, 'model');
    $release_year = filter_input(INPUT_POST, 'release-year');
    $price = filter_input(INPUT_POST, 'price');

    if(empty($brand) || empty($model) || empty($release_year) || empty($price)) {
        $error = "All fields must contain data. Please ensure all text boxes have appropriate values.";
        include 'view/watches_add.php';
    } else {
        $watch = new Watch($brand, $model, $release_year, $price);
        WatchesDB::addWatch($watch);
        $watches = WatchesDB::getWatches();
        header('Location:.');
        // used instead of include 'view/watches_list.php'; to prevent duplicate values from being saved on refresh
    }
} else if ($action == 'show-update-form') {
    $id = filter_input(INPUT_POST, 'ID');
    $watch = WatchesDB::getWatchInfo($id);
    include 'view/watches_update.php';
} else if ($action == 'update-watch') {
    $id = filter_input(INPUT_POST, 'ID');
    $brand = filter_input(INPUT_POST, 'brand');
    $model = filter_input(INPUT_POST, 'model');
    $release_year = filter_input(INPUT_POST, 'release-year');
    $price = filter_input(INPUT_POST, 'price');

    if (empty($brand) || empty($model) || empty($release_year) || empty($price)) {
        $error = "All fields must contain data. Please ensure all text boxes have appropriate values.";
        $watch = WatchesDB::getWatchInfo($id);
        include 'view/watches_update.php';
    } else {
        $watch = new Watch($brand, $model, $release_year, $price);
        $watch->setId($id);
        WatchesDB::updateWatch($watch);
        $watches = WatchesDB::getWatches();
        header('Location:.');
    }
} else if ($action == 'delete-watch') {
    $id = filter_input(INPUT_POST, 'ID');
    WatchesDB::deleteWatch($id);
    $watches = WatchesDB::getWatches();
    header('Location:.');
}