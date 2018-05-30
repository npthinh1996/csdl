<?php
require "./libs/std.php";
$id = isset($_POST['id']) ? (int)$_POST['id'] : '';
if($id){
    delete_std($id);
    disconnect_db();
}
header("location: std-list.php");
?>