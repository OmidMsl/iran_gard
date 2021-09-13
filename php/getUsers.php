<?php

require_once 'config.php';


// connect to database
$con = new mysqli(DB_HOST , DB_USER , DB_PASS , DB_NAME);

// check connection
if ($con->connect_error) {
    echo "Failed to connect : " . $con->connect_error;
    return;
}

mysqli_query( $con , "SET CHARACTER SET utf8;" );

$content = mysqli_query($con , "SELECT `id`, `name`, `isLeader`, `image` FROM `user`");
$output = array();

while($row = mysqli_fetch_array($content)){
    $record  = array();
    $record['id'] = $row['id'];
    $record['name'] = $row['name'];
    $record['isLeader'] = $row['isLeader'];
    $record['image'] = $row['image'];
    $output[] = $record;
}

echo json_encode($output);

