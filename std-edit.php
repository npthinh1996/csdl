<?php
require "./libs/std.php";

session_start();
if(empty($_SESSION['login-user'])){
    header('location: index.php');
}

$id = isset($_GET['id']) ? (int)$_GET['id'] : '';
if($id  && empty($_POST['edit_std'])) $data = get_std($id);
if(!empty($_POST['edit_std'])){
    $data['StudentID'] = isset($_POST['id']) ? $_POST['id'] : '';
    $data['StudentType'] = isset($_POST['type']) ? $_POST['type'] : '';
    $data['Name'] = isset($_POST['name']) ? $_POST['name'] : '';
    $data['Email'] = isset($_POST['email']) ? $_POST['email'] : '';
    $data['Phone'] = isset($_POST['phone']) ? $_POST['phone'] : '';

    $errors = array();
    if(empty($data['Name'])){
        $errors['Name'] = '* Not NULL';
    } else if($data['Name'] != preg_replace('/[^a-z A-Z]/','',$data['Name'])){
        $errors['Name'] = '* Not format';
    }
    if(!$errors){
        edit_std($data['StudentID'],$data['StudentType'],$data['Name'],$data['Email'],$data['Phone']);
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
    <title>Edit Student</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Edit Student</h1>
    <div style="text-align:center">Acc: <?php echo $_SESSION['login-user'] ?>
        | <a href="logout.php">Log out</a>
    </div>
    <hr width="200px">
    <form action="std-edit.php?id=<?php echo $data['StudentID']; ?>" method="post">
        <table id="styleAE">
            <tr>
                <td><a href="std-list.php">Come back</a></td>
            </tr>
            <tr>
                <th>ID</th>
                <td>
                    <input type="text" name="id" value="<?php echo $data['StudentID']; ?>" disabled>
                </td>
            </tr>
            <tr>
                <th>Type</th>
                <td>
                    <input type="text" name="type" value="<?php echo $data['StudentType']; ?>">
                </td>
            </tr>
            <tr>
                <th>Name</th>
                <td>
                    <input type="text" name="name" value="<?php echo (empty($_POST["Name"]) && empty($errors["Name"])) ? $data['Name'] : ''; ?>" placeholder='<?php if(!empty($errors["Name"])) echo $errors["Name"]; ?>'>
                </td>
            </tr>
            <tr>
                <th>Email</th>
                <td>
                    <input type="email" name="email" value="<?php echo $data['Email']; ?>">
                </td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>
                    <input type="text" name="phone" value="<?php echo $data['Phone']; ?>">
                </td>
            </tr>
            <tr>
                <td><input type="submit" name="edit_std" value="Commit"></td>
            </tr>
        </table>
        <input type="hidden" name="id" value="<?php echo $data['StudentID']; ?>">
    </form>
</body>
</html>