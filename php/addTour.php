<?php

require_once 'config.php';

// get parameters
if(isset($_REQUEST['title']) && isset($_REQUEST['startLocation'])
	&& isset($_REQUEST['destination']) && isset($_REQUEST['categories']) && isset($_REQUEST['capasity'])
	&& isset($_REQUEST['registered']) && isset($_REQUEST['price'])
	&& isset($_REQUEST['channelName']) && isset($_REQUEST['isRegistered'])
	&& isset($_REQUEST['lastEvent']) && isset($_REQUEST['date'])
	&& isset($_REQUEST['lastEventTime']) && isset($_REQUEST['numberOfNewEvents']) && isset($_REQUEST['duration'])) {
	$id = "NULL";
    if ($_REQUEST['subtitle'] === "") {
        $subtitle = "NULL";
    } else {
        $subtitle = $_REQUEST['subtitle'];
    }
    if ($_REQUEST['necessaryStuff'] === "") {
        $necessaryStuff = "NULL";
    } else {
        $necessaryStuff = $_REQUEST['necessaryStuff'];
    }
    if ($_REQUEST['channelImage'] === "") {
        $channelImage = "NULL";
    } else {
        $channelImage = $_REQUEST['channelImage'];
    }
    if ($_REQUEST['images'] === "") {
        $images = "NULL";
    } else {
        $images = $_REQUEST['images'];
    }
    $title = $_REQUEST['title'];
    $startLocation = $_REQUEST['startLocation'];
    $destination = $_REQUEST['destination'];
    $categories = $_REQUEST['categories'];
    $capasity = $_REQUEST['capasity'];
    $registered = $_REQUEST['registered'];
    $price = $_REQUEST['price'];
    $images = $_REQUEST['images'];
    $channelName = $_REQUEST['channelName'];
    $isRegistered = $_REQUEST['isRegistered'];
    $lastEvent = $_REQUEST['lastEvent'];
    $date = $_REQUEST['date'];
    $lastEventTime = $_REQUEST['lastEventTime'];
    $numberOfNewEvents = $_REQUEST['numberOfNewEvents'];
    $duration = $_REQUEST['duration'];
} else{
    echo "is not set";
    return;
}

// connect to database
$con = new mysqli(DB_HOST , DB_USER , DB_PASS , DB_NAME);

if (!$con->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $mysqli->error);
    exit();
}

mysql_query("SET NAMES 'utf8'");

// check connection
if ($con->connect_error) {
    echo "Failed to connect : " . $con->connect_error;
    return;
}

$sqlquery = "INSERT INTO `tour` (`title`, `subtitle`, `startLocation`, `destination`, `categories`, `capasity`, `registered`, `price`, `images`, `channelName`, `channelImage`, `isRegistered`, `necessaryStuff`, `lastEvent`, `date`, `lastEventTime`, `numberOfNewEvents`, `duration`) VALUES ('$title', '$subtitle', '$startLocation', '$destination', '$categories', $capasity, $registered, $price, '$images', '$channelName', '$channelImage', $isRegistered, '$necessaryStuff', '$lastEvent', '$date', '$lastEventTime', '$numberOfNewEvents', '$duration')";

if ($con->query($sqlquery) === true){
    $content = mysqli_query($con , "SELECT MAX(`id`) FROM `tour`");
    $tourresult = $content->fetch_array()[0];
    echo "$tourresult";
} else{
    echo "Error : " . $con->error;
}
