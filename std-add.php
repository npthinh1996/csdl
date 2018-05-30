<?php
require './libs/std.php';

session_start();
if(empty($_SESSION['login-user'])){
    header('location: index.php');
}

if(!empty($_POST['add_std'])){
    $data['StudentID'] = isset($_POST['id']) ? $_POST['id'] : '';
    $data['StudentType'] = isset($_POST['type']) ? $_POST['type'] : '';
    $data['Name'] = isset($_POST['name']) ? $_POST['name'] : '';
    $data['Email'] = isset($_POST['email']) ? $_POST['email'] : '';
    $data['Phone'] = isset($_POST['phone']) ? $_POST['phone'] : '';
    
    $errors = array();
    if(empty($data['StudentID'])){
        $errors["StudentID"] = '* Not NULL';
    } else if($data['StudentID'] != preg_replace('/[^0-9]/','',$data['StudentID'])){
        $errors['StudentID'] = '* Not format';
    }
    if(empty($data['Name'])){
        $errors['Name'] = '* Not NULL';
    } else if($data['Name'] != preg_replace('/[^a-z A-Z]/','',$data['Name'])){
        $errors['Name'] = '* Not format';
    }
    if(!$errors){
        add_std($data['StudentID'],$data['StudentType'],$data['Name'],$data['Email'],$data['Phone']);
        header("location: std-list.php");
    }
}
disconnect_db();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Add Student</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Add Student</h1>
    <div style="text-align:center">Acc: <?php echo $_SESSION['login-user'] ?>
        | <a href="logout.php">Log out</a>
    </div>
    <hr width="200px">
    <form action="std-add.php" method="post">
        <table id="styleAE">
            <tr>
                <td><a href="std-list.php">Come back</a></td>
            </tr>
            <tr>
                <th>ID</th>
                <td>
                    <input type="text" name="id" value="<?php echo (!empty($data['StudentID']) && empty($errors['StudentID'])) ? $data['StudentID'] : ''; ?>" placeholder='<?php echo !empty($errors["StudentID"]) ? $errors["StudentID"] : ""; ?>'>
                </td>
            </tr>
            <tr>
                <th>Type</th>
                <td>
                    <input type="text" name="type" value="<?php echo !empty($data['StudentType']) ? $data['StudentType'] : ''; ?>">
                </td>
            </tr>
            <tr>
                <th>Name</th>
                <td>
                    <input type="text" name="name" value="<?php echo (!empty($data['Name']) && empty($errors['Name'])) ? $data['Name'] : ''; ?>" placeholder='<?php echo !empty($errors["Name"]) ? $errors["Name"] : ""; ?>'>
                </td>
            </tr>
            <tr>
                <th>Email</th>
                <td>
                    <input type="email" name="email" value="<?php echo !empty($data['Email']) ? $data['Email'] : ''; ?>">
                </td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>
                    <input type="text" name="phone" value="<?php echo !empty($data['Phone']) ? $data['Phone'] : ''; ?>">
                </td>
            </tr>
            <tr>
                <td><input type="submit" name="add_std" value="Submit"></td>
            </tr>
        </table>
    </form>
</body>
</html>