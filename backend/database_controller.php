<?php
class DatabaseController
{

    public function addPost(PostModel $postModel)
    {
        include 'database_connection.php';

        $query = "insert into posts "
            . "(user_id,category_id,sub_category,description,country,city)"
            . " values ('{$postModel->getUserId()}','{$postModel->getCategoryId()}','{$postModel->getSubCategory()}',"
            . "'{$postModel->getDescription()}','{$postModel->getCountry()}','{$postModel->getCity()}')";
        $result = mysqli_query($connection, $query);
		$this->addImages($connection->insert_id, $postModel->getImages());
		return $result;
    }
    public function addImages(int $post_id, array $images)
    {
        include 'database_connection.php';
        $urls = $this->uploadImages($images);
        $values = '';
        foreach ($urls as $url) {
            $values .= "('$post_id','$url'),";
        }
        $values = substr($values, 0, -1);
        $query = "insert into images (post_id,image_url) values " . $values;
        return mysqli_query($connection, $query);
    }
    public function checkPhoneAndToken(String $phoneNumber, String $token)
    {
        include 'database_connection.php';
        $query = "select * from users where phone_number = '$phoneNumber' and token = '$token'";
        $result = mysqli_query($connection, $query);
        return $result->num_rows > 0;
    }
    public function checkCategoryExistence($category_id):mysqli_result
    {
        include 'database_connection.php';
        $query = "select * from categories where category_id='$category_id'";
        $result = mysqli_query($connection, $query);
        return $result;
    }
    public function getUserIdByToken(string $token)
    {
        $user_id = -1;
        include 'database_connection.php';
        $query = "select user_id from users where token = '$token'";
        $result = mysqli_query($connection, $query);
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
    public function getAllCategories()
    {
        include 'database_connection.php';
        $query = "select * from categories";
        $result = mysqli_query($connection,$query);
        $categories = array();
        if($result->num_rows>0)
        {
            for($i;$i<$result->num_rows;$i++){
                $row = $result->fetch_assoc();
                $category_id = $row['category_id'];
                $category_name = $row['category_name'];
                $categories[$category_id] = $category_name;
            }
        }
        return $categories;
    }
    public function getUsedCategories($byCity,$country,$city)
    {
        include 'database_connection.php';
        $query = "SELECT DISTINCT(p.category_id) as c_id,c.category_name as c_name FROM posts p 
        left outer JOIN categories c on c.category_id = p.category_id 
        where country = '$country'";
        if($byCity)
        $query .= " and city = '$city'";

        $result = mysqli_query($connection,$query);
        $categories = array();
        for($i;$i<$result->num_rows;$i++)
        {
            $row = $result->fetch_assoc();
            $category_id = $row['c_id'];
            $category_name = $row['c_name'];
            $categories[$category_id]=$category_name;
        }
        return $categories;
    }
}
