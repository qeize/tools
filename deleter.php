<?php
$currentDir = realpath(__DIR__);
$log = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $targetDir = $_POST['target_dir'] ?: $currentDir;
    $fileName = $_POST['file_name'] ?? '';

    if (!is_dir($targetDir)) {
        $log .= "<span style='color:red;'>❌ Direktori tidak valid: $targetDir</span><br>";
    } elseif (empty($fileName)) {
        $log .= "<span style='color:red;'>❌ Nama file tidak boleh kosong.</span><br>";
    } else {
        $deletedFiles = [];

        function deleteFileRecursive($dir, $fileToDelete, &$deletedFiles) {
            $files = scandir($dir);
            foreach ($files as $file) {
                if ($file === '.' || $file === '..') continue;

                $path = $dir . DIRECTORY_SEPARATOR . $file;

                if (is_dir($path)) {
                    deleteFileRecursive($path, $fileToDelete, $deletedFiles);
                } elseif ($file === $fileToDelete) {
                    if (unlink($path)) {
                        $deletedFiles[] = $path;
                    }
                }
            }
        }

        deleteFileRecursive($targetDir, $fileName, $deletedFiles);

        if (count($deletedFiles) > 0) {
            $log .= "<b>✅ File yang berhasil dihapus:</b><br>";
            foreach ($deletedFiles as $file) {
                $log .= "• $file<br>";
            }
        } else {
            $log .= "<i>📭 Tidak ada file \"$fileName\" ditemukan di direktori tersebut.</i><br>";
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>File Deleter</title>
    <style>
        body { font-family: Consolas, monospace; background: #111; color: #0f0; padding: 20px; }
        input[type="text"] { width: 90%; padding: 8px; background: #222; color: #0f0; border: 1px solid #0f0; }
        input[type="submit"] { background: #0f0; color: #000; padding: 8px 16px; border: none; cursor: pointer; }
        .log { margin-top: 20px; background: #222; padding: 10px; border-left: 3px solid #0f0; }
    </style>
</head>
<body>
    <h2>🧨 File Deleter</h2>
    <form method="POST">
        <label><b>📂 Direktori Target (default = sekarang):</b></label><br>
        <input type="text" name="target_dir" value="<?= htmlspecialchars($currentDir) ?>"><br><br>

        <label><b>🗑️ Nama File yang Dihapus:</b></label><br>
        <input type="text" name="file_name" placeholder="contoh: cgi_bin.php"><br><br>

        <input type="submit" value="HAPUS SEKARANG!">
    </form>

    <?php if ($log): ?>
        <div class="log"><?= $log ?></div>
    <?php endif; ?>
</body>
</html>