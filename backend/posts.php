<?php

$function = ($_POST['function']);
$postHandler = new PostsHandler;
switch ($function) {
    case 'add':
        $postHandler->addPost();
        break;
    default:
        echo 'wrong function !';
}
class PostsHandler
{
    public function addPost()
    {
        $dbController = new DatabaseController;
        $postModel = new PostModel;
        $phoneNumber = ($_POST['phone_number']);
        $user_token = ($_POST['user_token']);
        $postModel->setImages($_POST['images']);
        $postModel->setCategoryId($_POST['category_id']);
        $postModel->setSubCategory($_POST['sub_category']);
        $postModel->setDescription($_POST['description']);
        $postModel->setCountry($_POST['country']);
        $postModel->setCity($_POST['city']);

        if (!($dbController->checkPhoneAndToken($phoneNumber, $user_token))) {
            echo 'wront phone number or token!';
            return;
        }
        if (sizeof($postModel->getImages()) === 0) {
            echo 'no images provided!';
            return;
        }
        if ($dbController->checkCategoryExistence($postModel->getCategoryId())->num_rows === 0) {
            echo 'category id does not exist';
            return;
        }
        if (strlen($postModel->getSubCategory()) === 0) {
            echo 'sub category cannot be empty!';
            return;
        }
        if(strlen($postModel->getDescription())===0)
        {
            echo 'description cannot be empty!';
            return;
        }
    }
}
class PostModel
{
    private int $post_id;
    private int $user_id;
    private int $category_id;
    private String $sub_category;
    private String $description;
    private String $country;
    private String $city;
    private String $is_removed;
    private String $remove_id;
    private array $images;
    private array $images_urls;

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
    public function setImages(string $images)
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
