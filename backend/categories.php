<?php

$function = $_POST["function"];
$categoryHandler = new CategoryHandler;
switch ($function) {
    case 'get_all':
        $categoryHandler->getAllCategories();
        break;
    case 'get_used':
        $categoryHandler->getUsedCategories();
        break;
    default:
        echo 'wrong function !';
}
class CategoryHandler
{
    private $dbController = new DatabaseController;
    public function getAllCategories()
    {
        include 'database_controller.php';
        echo $this->dbController->getAllCategories();
    }
    public function getUsedCategories()
    {
        include 'database_controller.php';
        $byCity = $_POST['by_city'];
        $country = $_POST['country'];
        $city = $_POST['city'];
        echo json_encode($this->dbController->getUsedCategories($byCity, $country, $city));
    }
}
?>