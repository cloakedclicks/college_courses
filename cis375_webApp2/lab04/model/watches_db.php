<?php
function getWatches() {
    global $db;
    $query = 'SELECT * FROM watches ORDER BY Brand';
    $watches = $db->query($query);
    return $watches;
}
function addWatch($brand, $model, $release_year, $price) {
    global $db;
    $query = 'INSERT INTO watches
                (Brand, Model, ReleaseYear, Price)
              VALUES
                (:brand, :model, :release_year, :price)';
    $statement = $db->prepare($query);
    $statement->bindValue(':brand', $brand);
    $statement->bindValue(':model', $model);
    $statement->bindValue(':release_year', $release_year);
    $statement->bindValue(':price', $price);
    $statement->execute();
    $statement->closeCursor();
}
function getWatchInfo($id) {
    global $db;
    $query = 'SELECT * FROM watches WHERE ID = :watch_id';
    $statement = $db->prepare($query);
    $statement->bindValue(':watch_id', $id);
    $statement->execute();
    $watch = $statement->fetch();
    $statement->closeCursor();
    return $watch;
}
function updateWatch($id, $brand, $model, $release_year, $price) {
    global $db;
    $query = 'UPDATE watches
                SET ID = :watch_id,
                    Brand = :brand,
                    Model = :model,
                    ReleaseYear = :release_year,
                    Price = :price
                WHERE ID = :watch_id';
    $statement = $db->prepare($query);
    $statement->bindValue(':watch_id', $id);
    $statement->bindValue(':brand', $brand);
    $statement->bindValue(':model', $model);
    $statement->bindValue(':release_year', $release_year);
    $statement->bindValue(':price', $price);
    $statement->execute();
    $statement->closeCursor();
}
function deleteWatch($id) {
    global $db;
    $query = 'DELETE FROM watches WHERE ID = :watch_id';
    $statement = $db->prepare($query);
    $statement->bindValue(':watch_id', $id);
    $statement->execute();
    $statement->closeCursor();
}