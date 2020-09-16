<?php
///All php files have been uploaded to our host server, including the below information,
///but we have removed the connection information so it doesn't become public
///you can still test this code on any other server host (if necessary) by adding the server and database
///information below.
///if tested on another host server, make sure to create a folder called 'uploaded_images' in the same root
///and change its read/write permission so php can save the uploaded images to the folder when a post is added.
$username = '';
$password = '';
$host = 'raedghazal.com';
$db_name = '';

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
    PRIMARY KEY (user_id),
    UNIQUE KEY token (token),
    UNIQUE KEY phone_number (phone_number)
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
   
$checkingCategoryTable = "SHOW TABLES LIKE 'categories'";
$categoyExists = (mysqli_query($connection,$checkingCategoryTable)->num_rows)>0;

$create_categories_table = "CREATE TABLE IF NOT EXISTS categories (
    category_id int(11) NOT NULL AUTO_INCREMENT,
    category_name varchar(50) NOT NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY category_name (category_name)
   )";
mysqli_query($connection, $create_categories_table);

if(!$categoyExists)
{
    $addCategoriesQuery = "insert into categories values (1,'Furniture'),(2,'Clothes'),(3,'Electronics'),"
    ."(4,'Books'),(5,'Pets accessories'),(6,'Tools')" ;
    mysqli_query($connection,$addCategoriesQuery);
}

?>
