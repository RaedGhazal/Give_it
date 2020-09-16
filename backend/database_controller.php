<?php
class DatabaseController
{


    public function addUser(String $phoneNumber, String $country, String $token)
    {
        if ($this->checkUserExistence($phoneNumber, $token)) {
            echo 'user already exists';
            return false;    
        }
        if($this->checkPhoneNumberExistence($phoneNumber)){
            echo 'phone number already in use';
            return;
        }
        if($this->checkTokenExistence($token)){
            echo 'token already in use';
            return;
        }
        include 'database_connection.php';
            $query = "insert into users (phone_number,country,token) values ('$phoneNumber','$country','$token')";
            $result = mysqli_query($connection,$query);
            return $result;
    }
    public function checkPhoneNumberExistence($phoneNumber)
    {
        include 'database_connection.php';
        $query = "select * from users where phone_number = '$phoneNumber'";
        return mysqli_query($connection,$query)->num_rows;
    }
    public function checkTokenExistence($token)
    {
        include 'database_connection.php';
        $query = "select * from users where token = '$token'";
        return mysqli_query($connection,$query)->num_rows;
    }
    public function addPost(PostModel $postModel)
    {
        include 'database_connection.php';

        $query = "insert into posts "
            . "(user_id,category_id,sub_category,description,country,city)"
            . " values ('{$postModel->getUserId()}','{$postModel->getCategoryId()}','{$postModel->getSubCategory()}',"
            . "'{$postModel->getDescription()}','{$postModel->getCountry()}','{$postModel->getCity()}')";
        $result = mysqli_query($connection, $query);
        $postModel->setPostId($connection->insert_id);
        if(!($this->addImages($postModel->getPostId(), $postModel->getImages(),$postModel->getUserId())))
        {
            $query = "delete from posts where post_id = '{$postModel->getPostId()}'";
            mysqli_query($connection,$query);
            return false;
        }
        return $result;
    }
    public function addImages(int $post_id, array $images,$userId)
    {
        include 'database_connection.php';
        $urls = $this->uploadImages($images,$userId);

        if(sizeof($urls)===0)
        return false;

        $values = '';
        foreach ($urls as $url) {
            $values .= "('$post_id','$url'),";
        }
        $values = substr($values, 0, -1);
        $query = "insert into images (post_id,image_url) values " . $values;
        return mysqli_query($connection, $query);
    }
    public function getPosts($country, $city, $category_id)
    {
        include 'database_connection.php';

        $query = "select p.*,u.phone_number,c.category_name from posts p"
            . " left outer join users u on p.user_id = u.user_id"
            . " left outer join categories c on p.category_id = c.category_id"
            . " where p.is_removed = 0 and p.country = '$country'";

        if (strlen($city) > 0 && strtolower($city) != 'all')
            $query .= " and p.city = '$city'";
        if (strlen($category_id) > 0)
            $query .= " and p.category_id = '$category_id'";
        $result = mysqli_query($connection, $query);
        $posts = array();
        for ($i; $i < $result->num_rows; $i++) {
            $row = $result->fetch_assoc();
            unset($row["user_id"]);
            unset($row["is_removed"]);
            unset($row["remove_id"]);
            $row['images_urls'] = ($this->getImagesUrls($row['post_id']));
            $posts[] = $row;
        }
        return $posts;
    }
    public function getImagesUrls($post_id): array
    {
        include 'database_connection.php';
        $query = "select * from images where post_id = '$post_id'";
        $result = mysqli_query($connection, $query);
        $urls = array();
        for ($i; $i < $result->num_rows; $i++) {
            $urls[] = $result->fetch_assoc()['image_url'];
        }
        return $urls;
    }
    public function getAllCategories()
    {
        include 'database_connection.php';
        $query = "select * from categories order by category_id";
        $result = mysqli_query($connection, $query);
        $categories = array();
        if ($result->num_rows > 0) {
            for ($i; $i < $result->num_rows; $i++) {
                $row = $result->fetch_assoc();
                $category_id = $row['category_id'];
                $category_name = $row['category_name'];
                $categories[$category_id] = $category_name;
            }
        }
        return $categories;
    }
    public function getUsedCategories($country, $city)
    {
        include 'database_connection.php';
        $city = strtolower($city);
        $query = "SELECT DISTINCT(p.category_id) as c_id,c.category_name as c_name FROM posts p 
        left outer JOIN categories c on c.category_id = p.category_id 
        where p.is_removed = 0 and country = '$country'";
        if (strlen($city) > 0 && strtolower($city) != 'all')
            $query .= " and city = '$city'";

        $result = mysqli_query($connection, $query);
        $categories = array();
        for ($i; $i < $result->num_rows; $i++) {
            $row = $result->fetch_assoc();
            $category_id = $row['c_id'];
            $category_name = $row['c_name'];
            $categories[$category_id] = $category_name;
        }
        return $categories;
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
    public function checkUserExistence(String $phoneNumber, String $token)
    {
        include 'database_connection.php';
        $query = "select * from users where phone_number = '$phoneNumber' and token = '$token'";
        $result = mysqli_query($connection, $query);
        return $result->num_rows > 0;
    }
    public function checkCategoryExistence($category_id): mysqli_result
    {
        include 'database_connection.php';
        $query = "select * from categories where category_id='$category_id'";
        $result = mysqli_query($connection, $query);
        return $result;
    }
    public function uploadImages($images,$userId): array
    {
        $urls = array();
        foreach ($images as $image) {
            $allowedFilesExtentions = array('jpg', 'jpeg', 'png');
            $url = '';
            $realImage = base64_decode($image[0]);
            $imageName = $image[1];
            $fileExtention = strtolower(end(explode(".", $imageName)));
            $savingImageName = $userId.'image'.uniqid().'.'.$fileExtention;
            if (in_array($fileExtention, $allowedFilesExtentions)) {
                $path = __DIR__ . "/uploaded_images/$savingImageName";
                file_put_contents($path, $realImage);
                $url = "https://" . substr($path, strpos($path, 'raedghazal.com'));
                $url = substr($url, 0, 23) . '/' . substr($url, 23);
                $urls[] = $url;
            } else {
                echo 'this file type ' . $imageName . ' is not supported!';
            }
        }
        return $urls;
    }
}
