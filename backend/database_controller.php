<?php
class DatabaseController{

    public function addPost(PostModel $postModel)
    {
        //TODO add insert query
        include 'database_connection.php';
        $query = "insert into post "."()"." values ()"
    }
    public function checkPhoneAndToken(String $phoneNumber,String $email)
    {
        include 'database_connection.php';
        $query = "select * from users where phone_number = '$phoneNumber' and email = '$email'";
        $result = mysqli_query($connection,$query);
        return $result->num_rows > 0;
    }
    public function checkCategoryExistence($category_id) : mysqli_result
    {
        include 'database_connection.php';
        $query = "select * from categoies where category_id='$category_id'";
        $result = mysqli_query($connection,$query);
        return $result;
    }
}
?>