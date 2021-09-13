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

$content = mysqli_query($con , "SELECT * FROM `tour`");
$output = array();

while($row = mysqli_fetch_array($content)){
    $record  = array();
    $record['id'] = $row['id'];
    $record['title'] = $row['title'];
    $record['subtitle'] = $row['subtitle'];
    $record['startLocation'] = $row['startLocation'];
    $record['destination'] = $row['destination'];
    $record['categories'] = $row['categories'];
    $record['capasity'] = $row['capasity'];
    $record['registered'] = $row['registered'];
    $record['price'] = $row['price'];
    $record['images'] = $row['images'];
    $record['channelName'] = $row['channelName'];
    $record['channelImage'] = $row['channelImage'];
    $record['isRegistered'] = $row['isRegistered'];
    $record['necessaryStuff'] = $row['necessaryStuff'];
    $record['lastEvent'] = $row['lastEvent'];
    $record['date'] = $row['date'];
    $record['lastEventTime'] = $row['lastEventTime'];
    $record['numberOfNewEvents'] = $row['numberOfNewEvents'];
    $record['duration'] = $row['duration'];
    $output[] = $record;
}

echo json_encode($output);

