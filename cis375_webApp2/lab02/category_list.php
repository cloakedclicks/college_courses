<?php
require_once('database.php');

// Get all categories
$query = 'SELECT * FROM categories
                       ORDER BY categoryID';
$statement = $db->prepare($query);
$statement->execute();
$categories = $statement->fetchAll();
$statement->closeCursor();
?>
<!DOCTYPE html>
<html>

<!-- the head section -->
<head>
    <title>LaNier - Lab 2</title>
    <link rel="stylesheet" type="text/css" href="main.css" />
</head>

<!-- the body section -->
<body>
<header><h1>Product Manager</h1></header>
<main>
    <h1>Category List</h1>
    <table>
        <tr>
            <th> </th>
            <th>Name</th>
        </tr>
        <?php foreach ($categories as $category) : ?>
            <tr>
                <td>
                    <form action="delete_category.php" method="post">
                        <input type="hidden" name="category_id"
                               value="<?php echo $category['categoryID']; ?>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
                <td><?php echo $category['categoryName']; ?></td>
            </tr>
        <?php endforeach; ?>
    
    </table>

    <h2>Add Category</h2>
    <form action="add_category.php" method="post" id="add_category_form">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name">
        <input id="add_category_button" type="submit" value="Add">
    </form>
    
    <br>
    <p><a href="index.php">List Products</a></p>

    </main>

    <footer>
        <p>&copy; <?php echo date("Y"); ?> My Guitar Shop, Inc.</p>
    </footer>
</body>
</html>