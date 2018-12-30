<?php
function getWatches() {
    global $db;
    $query = 'SELECT * FROM watches ORDER BY Brand';
    $watches = $db->query($query);
    return $watches;
}