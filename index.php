<?php
require './libs/std.php';

session_start();
$errors = array();
if(!empty($_POST['submit'])){
    if(empty($_POST['username']) || empty($_POST['password'])){
        if(empty($_POST['username'])){
            $errors["username"] = '* Not NULL';
        }
        if(empty($_POST['password'])){
            $errors["password"] = '* Not NULL';
        }
    }
    else{
        $username = preg_replace('/[^0-9a-zA-Z]/','',$_POST['username']);
        $password = md5($_POST['password']);
        if(login($username,$password) == 1){
            $_SESSION['login-user'] = $username;
        } 
        else{
            header('location: index.php');
        }
    }
}

disconnect_db();

if(isset($_SESSION['login-user'])){
    header('location: std-list.php');
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
    <style>
        body{font-family:Calibri, sans-serif;font-size:1.25em;}
        h1{text-align:center;}
        form{margin:0 auto;width:300px;}
        input{font-size:1em;margin:5px 0;padding:5px;}
        input[type=text],input[type=password]{width:100%}
        input[type=submit]{background:lightcoral;color:white;font-weight:bold;border-radius:5px;border:0;outline:0;padding:3px;}
        input[type=submit]:active{background:black;}
        input::placeholder{color:red;font-style:italic;}
    </style>
</head>
<body>
    <h1>Login</h1>
    <form action="" method="post">
        <label for="username">Username</label>
        <input type="text" name="username" placeholder='<?php echo !empty($errors["username"]) ? $errors["username"] : ""; ?>'>
        <label for="password">Password</label>
        <input type="password" name="password" placeholder='<?php echo !empty($errors["password"]) ? $errors["password"] : ""; ?>'>
        <input type="submit" name="submit" value="Login">
    </form>
</body>
</html>