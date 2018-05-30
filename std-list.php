<?php
require './libs/std.php';

session_start();
if(empty($_SESSION['login-user'])){
    header('location: index.php');
}

$std = get_all_std();
$count = 0;
foreach($std as $item){
    if($item['Status'] == 'On') $count++;
}
disconnect_db();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Students</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>List Students</h1>
    <div style="text-align:center">Acc: <?php echo $_SESSION['login-user'] ?>
        | <a href="logout.php">Log out</a>
    </div>
    <hr width="200px">
    <table>
        <tr>
            <td><a href="std-add.php">Add new</a></td>
            <td style="color:blue">On LAB: <?php echo $count; ?></td>
            <td></td><td></td><td></td>
            <td><a href="trash.php">Trash</a></td>
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
        <tr <?php if($item["Status"] == 'On') echo 'class="onStatus" title="Student is using LAB"'; ?>>
            <td><?php echo $item["StudentID"]; ?></td>
            <td><?php echo $item["StudentType"] ?></td>
            <td><?php echo $item["Name"] ?></td>
            <td><?php echo $item["Email"] ?></td>
            <td><?php echo $item["Phone"] ?></td>
            <td style="background:white">
                <form action="std-delete.php" method="post">
                    <input type="button" value="Edit" onclick="window.location = 'std-edit.php?id=<?php echo $item['StudentID']; ?>'" style="width:40%">
                    <input type="hidden" name="id" value="<?php echo $item['StudentID']; ?>">
                    <input type="submit" value="Delete" name="delete" onclick="return confirm('Do you DELETE it?');" style="width:57%">
                </form>
            </td>
        </tr>
        <?php } ?>
    </table>
</body>
</html>