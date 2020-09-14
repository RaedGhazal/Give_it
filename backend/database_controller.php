<?php
class DatabaseController
{

    public function addPost(PostModel $postModel)
    {
        //TODO add insert query
        include 'database_connection.php';

        $query = "insert into post "
            . "(user_id,category_id,sub_category,description,country,city)"
            . " values ('{$postModel->getUserId()}','{$postModel->getCategoryId()}','{$postModel->getSubCategory()}',"
            . "'{$postModel->getDescription()}','{$postModel->getCountry()}','{$postModel->getCity()}')";

        $this->addImages($postModel->getPostId(), $postModel->getImages());
        mysqli_query($connection, $query);
    }
    public function addImages(int $post_id, array $images)
    {
        include 'database_connection.php';
        $urls = $this->uploadImages($images);
        $values = '';
        foreach ($urls as $url) {
            $values .= "('$post_id','$url'),";
        }
        substr($values, 0, -1);
        $query = "insert into images (post_id,image_url) values " . $values;
        return mysqli_query($connection, $query);
    }
    public function checkPhoneAndToken(String $phoneNumber, String $email)
    {
        include 'database_connection.php';
        $query = "select * from users where phone_number = '$phoneNumber' and email = '$email'";
        $result = mysqli_query($connection, $query);
        return $result->num_rows > 0;
    }
    public function checkCategoryExistence($category_id): mysqli_result
    {
        include 'database_connection.php';
        $query = "select * from categoies where category_id='$category_id'";
        $result = mysqli_query($connection, $query);
        return $result;
    }
    public function getUserIdByToken(int $token)
    {
        $user_id = -1;
        include 'database_connection.php';
        $query = "select user_id from users where token = '$token'";
        $result = mysqli_query($connection, $result);
        if ($result->num_rows > 0)
            $user_id = $result->fetch_assoc()['user_id'];
        return $user_id;
    }

    public function uploadImages($images): array
    {
        $urls = array();
        foreach ($images as $image) {
            $allowedFilesExtentions = array('jpg', 'jpeg', 'png');
            $url = '';
            $realImage = base64_decode($image[0]);
            $imageName = $image[1];
            $fileExtention = strtolower(end(explode(".", $imageName)));
            if (in_array($fileExtention, $allowedFilesExtentions)) {
                $path = __DIR__ . "/uploaded_images/$imageName";
                file_put_contents($path, $realImage);
                $url = substr($path, strpos($path, 'raedghazal.com'));
            } else {
                echo 'this file type ' . $imageName . ' is not supported!';
            }
            $urls[] = $url;
        }
        return $urls;
    }
}
?>