<?php

$function = $_POST['function'];
$postHandler = new PostsHandler;
switch ($function) {
    case 'add':
        $postHandler->addPost();
        break;
    case 'getAll':

    default:
        echo 'wrong function !';
}
class PostsHandler
{
    public function addPost()
    {
        include 'database_controller.php';
        $postModel = new PostModel;
        $phoneNumber = ($_POST['phone_number']);
        $user_token = ($_POST['user_token']);
        $postModel->setImages(json_decode($_POST['images']));
        $postModel->setCategoryId($_POST['category_id']);
        $postModel->setSubCategory($_POST['sub_category']);
        $postModel->setDescription($_POST['description']);
        $postModel->setCountry($_POST['country']);
        $postModel->setCity($_POST['city']);

        $dbController = new DatabaseController;
        if (!($dbController->checkPhoneAndToken($phoneNumber, $user_token))) {
            echo 'wrong phone number or token!';
            return;
        }
        $postModel->setUserId($dbController->getUserIdByToken($user_token));
        $postValidation = $this->checkPostValidation($postModel);
        if (!($postValidation === true)) {
            echo $postValidation;
            return;
        }
        echo $dbController->addPost($postModel)?'success':'fail';
    }
    public function getAllPosts()
    {
        
    }
    public function checkPostValidation(PostModel $postModel)
    {
        $dbController = new DatabaseController;

        if($postModel->getUserId()===-1)
        {
            return 'user doesn not exist!';
        }
        if (sizeof($postModel->getImages()) === 0) {
            return 'no images provided!';
        }
        if ($dbController->checkCategoryExistence($postModel->getCategoryId())->num_rows === 0) {
            return 'category id does not exist';
        }
        if (strlen($postModel->getSubCategory()) === 0) {
            return 'sub category cannot be empty!';
        }
        if (strlen($postModel->getDescription()) === 0) {
            return 'description cannot be empty!';
        }
        if (strlen($postModel->getCountry()) === 0) {
            return 'country cannot be empty!';
        }
        if (strlen($postModel->getCity()) === 0) {
            return 'city cannot be empty!';
        }
        return true;
    }
}
class PostModel
{
    private $post_id;
    private $user_id;
    private $category_id;
    private $sub_category;
    private $description;
    private $country;
    private $city;
    private $is_removed;
    private $remove_id;
    private $images;
    private $images_urls;

    public function setPostId(int $post_id)
    {
        $this->post_id = $post_id;
    }
    public function getPostId(): int
    {
        return $this->post_id;
    }
    public function setUserId(int $user_id)
    {
        $this->user_id = $user_id;
    }
    public function getUserId(): int
    {
        return $this->user_id;
    }
    public function setCategoryId(int $category_id)
    {
        $this->category_id = $category_id;
    }
    public function getCategoryId(): int
    {
        return $this->category_id;
    }
    public function setSubCategory(string $sub_category)
    {
        $this->sub_category = $sub_category;
    }
    public function getSubCategory(): string
    {
        return $this->sub_category;
    }
    public function setDescription(string $description)
    {
        $this->description = $description;
    }
    public function getDescription(): string
    {
        return $this->description;
    }
    public function setCountry(string $country)
    {
        $this->country = $country;
    }
    public function getCountry(): string
    {
        return $this->country;
    }
    public function setCity(string $city)
    {
        $this->city = $city;
    }
    public function getCity(): string
    {
        return $this->city;
    }
    public function setImages(array $images)
    {
        $this->images = $images;
    }
    public function getImages(): array
    {
        return $this->images;
    }
    public function setImagesUrls(string $images_urls)
    {
        $this->images_urls = $images_urls;
    }
    public function getImagesUrls(): array
    {
        return $this->images_urls;
    }
}
?>