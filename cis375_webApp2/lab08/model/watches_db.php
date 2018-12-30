<?php
class WatchesDB {
    public static function getWatches()
    {
        $db = Database::getDB();
        $query = 'SELECT * FROM watches ORDER BY Brand';
        $statement = $db->query($query);
        $statement->execute();
        $rows = $statement->fetchAll();
        $statement->closeCursor();

        foreach ($rows as $row) {
            $watch = new Watch($row['Brand'], $row['Model'], $row['ReleaseYear'], $row['Price']);
            $watch->setId($row['ID']);
            $watches[] = $watch;
        }
        return $watches;
    }

    public static function addWatch($watch)
    {
        $db = Database::getDB();

        $brand = $watch->getBrand();
        $model = $watch->getModel();
        $release_year = $watch->getReleaseYear();
        $price = $watch->getPrice();

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

    public static function getWatchInfo($id)
    {
        $db = Database::getDB();

        $query = 'SELECT * FROM watches WHERE ID = :watch_id';
        $statement = $db->prepare($query);
        $statement->bindValue(':watch_id', $id);
        $statement->execute();
        $row = $statement->fetch();
        $statement->closeCursor();
        $watch = new Watch($row['Brand'], $row['Model'], $row['ReleaseYear'], $row['Price']);
        $watch->setId($row['ID']);
        return $watch;
    }

    public static function updateWatch($watch)
    {
        $db = Database::getDB();

        $id = $watch->getId();
        $brand = $watch->getBrand();
        $model = $watch->getModel();
        $release_year = $watch->getReleaseYear();
        $price = $watch->getPrice();

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

    public static function deleteWatch($id)
    {
        $db = Database::getDB();
        $query = 'DELETE FROM watches WHERE ID = :watch_id';
        $statement = $db->prepare($query);
        $statement->bindValue(':watch_id', $id);
        $statement->execute();
        $statement->closeCursor();
    }
}