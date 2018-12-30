<?php include 'header.php'; ?>
<h4>Add Watch</h4>
<hr>
<form class="form-horizontal" action="." method="post">
    <div class="form-group">
        <label class="control-label col-md-2" for="brand">Watch Brand</label>
        <div class="col-md-4">
            <input type="text" name="brand" id="brand" placeholder="Brand" class="form-control" autofocus>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2" for="model">Model</label>
        <div class="col-md-4">
            <input type="text" name="model" id="model" placeholder="Model" class="form-control" autofocus>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2" for="release-year">Release Year</label>
        <div class="col-md-4">
            <input type="text" name="release-year" id="release-year" placeholder="Year of Release" class="form-control" autofocus>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2" for="price">Price</label>
        <div class="col-md-4">
            <input type="text" name="price" id="price" placeholder="Price" class="form-control" autofocus>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-4">
            <input type="hidden" name="action" value="add-watch">
            <input type="submit" value="Add Watch" class="btn btn-default">
            <p class="text-danger" style="margin-top: 20px; font-weight: bold"><?php echo $error; ?></p>
        </div>
    </div>
</form>
<?php include 'footer.php'; ?>