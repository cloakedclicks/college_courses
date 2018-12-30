<?php include 'header.php'; ?>
<table class="table table-bordered table-striped table-hover">
    <caption>Watch List</caption>
    <tr>
        <th>Brand</th>
        <th>Model</th>
        <th>Release Year</th>
        <th>Price</th>
        <th>Action</th>
    </tr>
    <?php foreach ($watches as $watch) : ?>
    <tr>
        <td><?php echo $watch->getBrand(); ?></td>
        <td><?php echo $watch->getModel(); ?></td>
        <td><?php echo $watch->getReleaseYear(); ?></td>
        <td><?php echo $watch->getPrice(); ?></td>
        <td>
            <form action="." method="post" class="btn-group">
                <input type="hidden" name="action" value="show-update-form">
                <input type="hidden" name="ID" value="<?php echo $watch->getId(); ?>">
                <input type="submit" class="btn btn-default" value="Update">
            </form>
            <form action="." method="post" class="btn-group">
                <input type="hidden" name="action" value="delete-watch">
                <input type="hidden" name="ID" value="<?php echo $watch->getId(); ?>">
                <input type="submit" class="btn btn-default" value="Delete">
            </form>
        </td>
    </tr>
    <?php endforeach; ?>
</table>
<form action="." method="post">
    <input type="hidden" name="action" value="show-add-form">
    <input type="submit" class="btn btn-default" value="Add Watch">
</form>
<?php include 'footer.php'; ?>
