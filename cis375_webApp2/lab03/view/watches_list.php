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
        <td><?php echo $watch['Brand']; ?></td>
        <td><?php echo $watch['Model']; ?></td>
        <td><?php echo $watch['ReleaseYear']; ?></td>
        <td><?php echo $watch['Price']; ?></td>
        <td>
            <form action="." method="post" class="btn-group">
                <input type="hidden" name="action" value="show-update-form">
                <input type="hidden" name="ID" value="<?php echo $watch['ID']; ?>">
                <input type="submit" class="btn btn-default" value="Update">
            </form>
            <form action="." method="post" class="btn-group">
                <input type="hidden" name="action" value="delete-watch">
                <input type="hidden" name="ID" value="<?php echo $watch['ID']; ?>">
                <input type="submit" class="btn btn-default" value="Delete">
            </form>
        </td>
    </tr>
    <?php endforeach; ?>
</table>
<?php include 'footer.php'; ?>
