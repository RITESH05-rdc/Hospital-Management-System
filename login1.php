<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/nav.css">
    <title>Login</title>
</head>
<body>
    
<?php


session_start();

    $_SESSION["user"]="";
    $_SESSION["usertype"]="";

    include("connection.php");  


    if($_POST){

        $email=$_POST['email'];
        $password=$_POST['password'];

       

        $result= $database->query("select * from users where email='$email'");
        if($result->num_rows==1){
            $utype=$result->fetch_assoc()['usertype'];
            if ($utype=='p'){
                
                $checker = $database->query("select * from patient where pemail='$email' and ppassword='$password'");
                if ($checker->num_rows==1){


                    //Session to store login info
                    $patient = $checker->fetch_assoc();
        
                    // Store the patient's email and name in session
                    $_SESSION['user'] = $patient['pemail'];
                    $_SESSION['usertype'] = 'p';
                    $_SESSION['patient_name'] = $patient['Pname'];
                    $_SESSION['Pid'] = $patient['Pid'];
                    // $_SESSION['patient_id'] = $patient_id;
                    echo $_SESSION['Pid'];




                    // //Patient
                    // $_SESSION['user']=$email;
                    // $_SESSION['usertype']='p';
                    
                    header('location: patient/index.php');
                   
                }

            }elseif($utype=='a'){
                
                $checker = $database->query("select * from admin where aemail='$email' and apassword='$password'");
                if ($checker->num_rows==1){


                    //Admin 
                    
                    $_SESSION['user']=$email;
                    $_SESSION['usertype']='a';
                    
                    header('location: admin/index.php');

                }


            }elseif($utype=='d'){
                
                $checker = $database->query("select * from doctor where Email='$email' and Password='$password'");
                if ($checker->num_rows==1){

                    $doctor = $checker->fetch_assoc();
                    //doctor 
                    $_SESSION['user']=$email;
                    $_SESSION['usertype']='d';
                    $_SESSION['doctor_name'] = $doctor['Name'];
                    $_SESSION['Did'] = $doctor['Did'];
                    header('location: doctor/index.php');


                }

            }
            
        }
        
    }

?>

<?php
include("include/nav.php");
?>



<div class="container">


<form class="form" action="" method="POST">

<h1>Welcome Back</h1>
<p>Enter your credentials to login</p>
<br/>


<input class="txtb" type="email" name="email" placeholder="Email"  autocomplete="on">
<br>


<input class="txtb" type="password" name="password" placeholder="Password" autocomplete="off">
<br>


<input class="submit-btn" type="submit" value="Login">

<p>Don't have an account? <a href="signup.php">Sign Up</a></p>
</form>



</div>



</body>
</html>