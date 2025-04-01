<?php

    $conn= new mysqli("localhost","root","","dotor");
    if ($conn->connect_error){
        die("Connection failed:  ".$conn->connect_error);
    }
    error_log("Database connection successful");
?>