<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/nav.css">

    <title>Patient Login</title>
</head>
<body>

<?php
session_start();
$_SESSION["user"] = "";
$_SESSION["usertype"] = "";
include("connection.php");

if ($_POST) {
    $email = $_POST['email'];
    $password = $_POST['password'];
    $result = $database->query("SELECT * FROM patient WHERE pemail='$email' AND ppassword='$password'");
    
    if ($result->num_rows == 1) {
        $patient = $result->fetch_assoc();
        $_SESSION['user'] = $patient['pemail'];
        $_SESSION['usertype'] = 'p';
        $_SESSION['patient_name'] = $patient['Pname'];
        $_SESSION['Pid'] = $patient['Pid'];
        header('location: patient/index.php');
    } else {
        echo "Invalid login credentials";
    }
}
?>

<?php
include("include/nav.php");
?>


<div class="container">
    <form class="form" action="" method="POST">
        <h1>Patient Login</h1>
        <input class="txtb" type="email" name="email" placeholder="Email" required>
        <input class="txtb" type="password" name="password" placeholder="Password" required>
        <input class="submit-btn" type="submit" value="Login">

    <div class="links">
    <p style="color:#1289a7;"><a href="login.php">Patient Login</a></p>
    <p style="color:black;"><a href="doctor_login.php">Doctor Login</a></p>
    <p><a href="admin_login.php">Admin Login</a></p>
    </form>
    
</div>
</div>

</body>
</html>
