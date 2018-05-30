<?php
require "./libs/std.php";
if($_POST['id']){
    delete_trash($_POST['id']);
    disconnect_db();
}
header("location: trash.php");
?>