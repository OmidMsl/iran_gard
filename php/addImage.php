<?php

require_once 'config.php';

// get parameters
if(isset($_REQUEST['image']) && isset($_REQUEST['name'])) {
    $name = $_REQUEST['name'];
    $image = $_REQUEST['image'];
} else{
    return;
}

$realImage = base64_decode($image);
 
file_put_contents("pics/".$name.".jpeg", $realImage);

echo "Image Uploaded Successfully.";;
?>

