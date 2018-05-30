<?php
require "./libs/std.php";
if($_POST['id']){
    add_std($_POST['id'],$_POST['type'],$_POST['name'],$_POST['email'],$_POST['phone']);
    delete_trash($_POST['id']);
    disconnect_db();
}
header("location: std-list.php");
?>