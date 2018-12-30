<?php include 'header.php'; ?>
    <h4>Update Watch</h4>
    <hr>
    <form class="form-horizontal" action="." method="post">
        <div class="form-group">
            <label class="control-label col-md-2" for="ID">Watch ID</label>
            <div class="col-md-4">
                <input type="text" name="ID" id="ID" value="<?php echo $watch['ID']; ?>" class="form-control" disabled>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="brand">Watch Brand</label>
            <div class="col-md-4">
                <input type="text" name="brand" id="brand" value="<?php echo $watch['Brand']; ?>" class="form-control" autofocus>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="model">Model</label>
            <div class="col-md-4">
                <input type="text" name="model" id="model" value="<?php echo $watch['Model']; ?>" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="release-year">Release Year</label>
            <div class="col-md-4">
                <input type="text" name="release-year" id="release-year" value="<?php echo $watch['ReleaseYear']; ?>" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="price">Price</label>
            <div class="col-md-4">
                <input type="text" name="price" id="price" value="<?php echo $watch['Price']; ?>" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-4">
                <input type="hidden" name="ID" value="<?php echo $watch['ID']; ?>">
                <input type="hidden" name="action" value="update-watch">
                <input type="submit" value="Update Watch" class="btn btn-default">
                <p class="text-danger" style="margin-top: 20px; font-weight: bold"><?php echo $error; ?></p>
            </div>
        </div>
    </form>
<?php include 'footer.php'; ?>