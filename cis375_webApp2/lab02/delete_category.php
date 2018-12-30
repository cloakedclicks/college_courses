<?php
/**
 * Created by PhpStorm.
 * User: robertlanier
 * Date: 1/24/18
 * Time: 11:24 PM
 */
$category_id = filter_input(INPUT_POST, 'category_id');

// Validate inputs
if ($category_id == null || $category_id == false) {
    $error = "Invalid category ID.";
    include 'error.php';
}  else {
    require_once 'database.php';

    // Add the category to the database
    $query = 'DELETE FROM categories WHERE categoryID = :category_id';
    $statement = $db->prepare($query);
    $statement->bindValue(':category_id', $category_id);
    $statement->execute();
    $statement->closeCursor();

    // Display the Category List page
    include 'category_list.php';
}