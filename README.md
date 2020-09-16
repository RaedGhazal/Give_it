# Give_it

An application where people give what they don't want anymore to ohter who is in need for these things.

The app will support Android , Ios and Web (currently the app support android only).

release build for Android : https://github.com/RaedGhazal/Give_it/blob/master/app-release.apk
or you can use the description below to regenerate it.

Used technologies:
 1. Flutter & Dart for devloping the frontend.
 2. Php & MySql for server api and database.
 3. Firebase for phone authentication.

  How to make a release a build:  
 1. download Android Studio   
 2. Download Dart Sdk & Flutter Sdk.   
 3. connect the app to firebase.  
 4. enable phone authentication. 
 5. call the command flutter run --release   the apk
    will be generated in the following path:
    Give_it\mobile_app\build\app\outputs\apk\release\app-release.apk

code used to generate the database and server connection:

    <?php
    ///All php files have been uploaded to my host server, including the following information,
    ///but I removed them from here so it doesn't become public to anyone who enters thig github repo
    ///you can still test this code on any other server host (if necessary) by adding the server and database
    ///information below.
    ///if tested on another host server, make sure to create a folder called 'uploaded_images' in the same root
    ///and change its read write permission so php can save the uploaded images to the folder when a post is added.
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

