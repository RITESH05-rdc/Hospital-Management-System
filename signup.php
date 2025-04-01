<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/signup.css">
    <link rel="stylesheet" href="css/nav.css">

    <title>SignUp</title>
</head>
<body>
    <!-- <h1>SignUp</h1> -->


<!-- Php code for signup -->
<?php
session_start();

//import database
include("connection.php");

if($_POST){

    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $name = $fname." ".$lname;
    $email = $_POST['email'];
    $contact = $_POST['phone'];
    $password = $_POST['password'];
    $cpassword = $_POST['cpassword'];
    $gender = $_POST['gender'];
    $age = $_POST['age'];
    $address = $_POST['address'];

    if($password == $cpassword){
        $database->query("insert into patient(Pname,pemail,ppassword,Age,Address,Phone_no,Gender) values('$name','$email','$password','$age','$address','$contact','$gender')");
        $database->query("insert into users(email,usertype) values('$email','p')");
        header('Location: patient/index.html');
    }
    else{
        $error='<label for="promter" class="form-label" style="color:rgb(255, 62, 62);text-align:center;">Password Conformation Error! Reconform Password</label>';
    }

    error_log("Signed Up successfully");
    error_log("First Name: " . $fname);
    error_log("Last Name: " . $lname);
    error_log("Email: " . $email);
    error_log("Contact: " . $contact);
    error_log("Password: " . $password);
    error_log("Confirm Password: " . $cpassword);
    error_log("Gender: " . $gender);
    error_log("Age: " . $age);
}
?>

<?php
include("include/nav.php");
?>

<!-- Form -->
<div class="container">

<form class="form" action="" method="POST">
<h1>SIGNUP</h1>
<input class="txtb" type="text" name="fname" placeholder="First Name"><br>

<input class="txtb" type="text" name="lname" placeholder="Last Name"><br>

<input class="txtb" type="email" name="email" placeholder="Email"><br>

<input class="txtb" type="text" name="address" placeholder="Address"><br>

<input class="txtb" type="text" name="phone" placeholder="Phone Number"><br>

<input class="txtb" type="number" name="age" placeholder="Age"><br>

<select name="gender">
    <option value="" disabled selected>Gender</option>
    <option value="male">Male</option>
    <option value="female">Female</option>
    <option value="other">Other</option>
</select><br>

<input class="txtb" type="Password" name="password" placeholder="Password"><br>

<input class="txtb" type="Password" name="cpassword" placeholder="Confirm Password"><br>

<input class="submit-btn" type="submit" value="NEXT">
<br>
<input class="reset-btn" type="reset" value="RESET">
<p>Have an account? <a href="login.php">login</a></p>
</form>
</div>
</body>
</html>