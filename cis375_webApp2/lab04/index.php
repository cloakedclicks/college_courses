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
        addWatch($brand, $model, $release_year, $price);
        $watches = getWatches();
        header('Location:.');
        // used instead of include 'view/watches_list.php'; to prevent duplicate values from being saved on refresh
    }
} else if ($action == 'show-update-form') {
    $id = filter_input(INPUT_POST, 'ID');
    $watch = getWatchInfo($id);
    include 'view/watches_update.php';
} else if ($action == 'update-watch') {
    $id = filter_input(INPUT_POST, 'ID');
    $brand = filter_input(INPUT_POST, 'brand');
    $model = filter_input(INPUT_POST, 'model');
    $release_year = filter_input(INPUT_POST, 'release-year');
    $price = filter_input(INPUT_POST, 'price');

    if (empty($brand) || empty($model) || empty($release_year) || empty($price)) {
        $error = "All fields must contain data. Please ensure all text boxes have appropriate values.";
        $watch = getWatchInfo($id);
        include 'view/watches_update.php';
    } else {
        updateWatch($id, $brand, $model, $release_year, $price);
        $watches = getWatches();
        header('Location:.');
    }
} else if ($action == 'delete-watch') {
    $id = filter_input(INPUT_POST, 'ID');
    deleteWatch($id);
    $watches = getWatches();
    header('Location:.');
}