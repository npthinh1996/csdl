<?php
global $conn;
function connect_db(){
    global $conn;
    if(!$conn){
        $conn = new mysqli("localhost", "root", "", "csdl");
        if($conn->connect_errno){
            echo "Failed to connect to MySQL: " . $conn->connect_error;
        }
    }
}
function disconnect_db(){
    global $conn;
    if($conn) $conn->close();
}
function get_all_std(){
    global $conn;
    connect_db();
    $sql = "CALL get_all_std()";
    $que = $conn->query($sql);
    $res = array();
    if($que){
        while($row = $que->fetch_assoc()){
            $res[] = $row;
        }
    }
    return $res;
}
function get_std($std_id){
    global $conn;
    connect_db();
    $sql = "CALL get_std($std_id)";
    $que = $conn->query($sql);
    if($que->num_rows > 0){
        $row = $que->fetch_assoc();
        $res = $row;
    }
    return $res;
}
function add_std($std_id,$std_type,$std_name,$std_email,$std_phone){
    global $conn;
    connect_db();
    $std_id = (int)$std_id;
    $std_type = preg_replace('/[^a-zA-Z]/','',$std_type);
    $std_name = preg_replace('/[^a-z A-Z]/','',$std_name);
    $std_phone = preg_replace('/[^0-9]/','',$std_phone);
    $sql = "CALL add_std($std_id,'$std_type','$std_name','$std_email','$std_phone')";
    $que = $conn->query($sql);
    return $que;
}
function edit_std($std_id,$std_type,$std_name,$std_email,$std_phone){
    global $conn;
    connect_db();
    $std_id = (int)$std_id;
    $std_type = preg_replace('/[^a-zA-Z]/','',$std_type);
    $std_name = preg_replace('/[^a-z A-Z]/','',$std_name);
    $std_phone = preg_replace('/[^0-9]/','',$std_phone);
    $sql = "CALL edit_std($std_id,'$std_type','$std_name','$std_email','$std_phone')";
    $que = $conn->query($sql);
    return $que;
}
function delete_std($std_id){
    global $conn;
    connect_db();
    $sql = "CALL delete_std($std_id)";
    $que = $conn->query($sql);
    return $que;
}
function get_trash(){
    global $conn;
    connect_db();
    $sql = "CALL get_trash()";
    $que = $conn->query($sql);
    $res = array();
    if($que){
        while($row = $que->fetch_assoc()){
            $res[] = $row;
        }
    }
    return $res;
}
function delete_trash($std_id){
    global $conn;
    connect_db();
    $sql = "CALL delete_trash($std_id)";
    $que = $conn->query($sql);
    return $que;
}
function login($user,$pass){
    global $conn;
    connect_db();
    $sql = "CALL login($user,'$pass')";
    $que = $conn->query($sql);
    return $que->num_rows;
}
?>