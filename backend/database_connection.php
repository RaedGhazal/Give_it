<?php

$username = 'arqaa_teamGiveit';
$password = 'ATGiveItProject1292020';
$host = 'raedghazal.com';
$db_name = 'arqaamso_giveit_db';

$connection = mysqli_connect($host, $username, $password, $db_name);
if (!$connection)
    echo 'connection failed';


//Creating project tables

$create_users_table = "CREATE TABLE IF NOT EXISTS users (
    user_id int(10) NOT NULL AUTO_INCREMENT,
    phone_number varchar(25) NOT NULL,
    country varchar(25) DEFAULT NULL,
    is_banned tinyint(1) NOT NULL DEFAULT '0',
    ban_id int(3) NOT NULL DEFAULT '0',
    token varchar(30) NOT NULL,
    PRIMARY KEY (user_id)
   )";
mysqli_query($connection, $create_users_table);

$create_posts_table = "CREATE TABLE IF NOT EXISTS posts (
    post_id int(11) NOT NULL AUTO_INCREMENT,
    user_id int(11) NOT NULL,
    category_id int(11) NOT NULL,
    sub_category varchar(50) NOT NULL,
    description varchar(150) NOT NULL,
    country varchar(60) NOT NULL,
    city varchar(85) NOT NULL,
    is_removed int(11) NOT NULL DEFAULT '0',
    remove_id int(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (post_id)
   )";
mysqli_query($connection, $create_posts_table);

$create_images_table = "CREATE TABLE IF NOT EXISTS images (
    image_id int(11) NOT NULL AUTO_INCREMENT,
    post_id int(11) NOT NULL,
    image_url varchar(300) NOT NULL,
    PRIMARY KEY (image_id)
   )";
mysqli_query($connection, $create_images_table);
   
$create_categories_table = "CREATE TABLE IF NOT EXISTS categories (
    category_id int(11) NOT NULL AUTO_INCREMENT,
    category_name varchar(50) NOT NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY category_name (category_name)
   )";
mysqli_query($connection, $create_categories_table);
?>
