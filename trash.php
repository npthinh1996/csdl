<?php
require './libs/std.php';

session_start();
if(empty($_SESSION['login-user'])){
    header('location: index.php');
}

$std = get_trash();
disconnect_db();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Trash</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1 style="color:lightcoral">Trash Data</h1>
    <div style="text-align:center">Acc: <?php echo $_SESSION['login-user'] ?>
        | <a href="logout.php">Log out</a>
    </div>
    <hr width="200px">
    <table>
        <tr>
            <td><a href="std-list.php">Come back</a></td>
        </tr>
        <tr>
            <th style="width:10%">ID</th>
            <th style="width:10%">Type</th>
            <th style="width:25%">Name</th>
            <th style="width:25%">Email</th>
            <th style="width:10%">Phone</th>
            <th style="width:10%">Option</th>
        </tr>
        <?php foreach($std as $item){ ?>
        <tr>
            <td><?php echo $item["StudentID"]?></td>
            <td><?php echo $item["StudentType"] ?></td>
            <td><?php echo $item["Name"] ?></td>
            <td><?php echo $item["Email"] ?></td>
            <td><?php echo $item["Phone"] ?></td>
            <td style="background:white">
                <form action="trash-restore.php" method="post">
                    <input type="hidden" name="id" value="<?php echo $item['StudentID']; ?>">
                    <input type="hidden" name="type" value="<?php echo $item['StudentType']; ?>">
                    <input type="hidden" name="name" value="<?php echo $item['Name']; ?>">
                    <input type="hidden" name="email" value="<?php echo $item['Email']; ?>">
                    <input type="hidden" name="phone" value="<?php echo $item['Phone']; ?>">
                    <input type="submit" value="Restore" name="restore" style="font-size:0.75em;width:48%;padding:6px 0">
                </form>
                <form action="trash-delete.php" method="post">
                    <input type="hidden" name="id" value="<?php echo $item['StudentID']; ?>">
                    <input type="submit" value="Delete" name="delete" onclick="return confirm('Do you DELETE it?');" style="font-size:0.75em;width:48%;padding:6px 0">
                </form>
            </td>
        </tr>
        <?php } ?>
        <tr><td style="background:white"><?php echo empty($std) ? 'Empty' : ''; ?></td></tr>
    </table>
</body>
</html>