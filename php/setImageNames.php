<?php

require_once 'config.php';

// get parameters
if(isset($_REQUEST['id']) && isset($_REQUEST['images'])) {
	
    $id = $_REQUEST['id'];
    $images = $_REQUEST['images'];
} else{
    return;
}

// connect to database
$con = new mysqli(DB_HOST , DB_USER , DB_PASS , DB_NAME);

// check connection
if ($con->connect_error) {
    echo "Failed to connect : " . $con->connect_error;
    return;
}

$sqlquery = "UPDATE `tour` SET `images` = '$images' WHERE `tour`.`id` = $id;";

if ($con->query($sqlquery) === true){
    echo "table updated successfully";
} else{
    echo "Error : " . $con->error;
}
