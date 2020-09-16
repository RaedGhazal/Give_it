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
    public function getAllCategories()
    {
        include 'database_controller.php';
        echo json_encode((new DatabaseController)->getAllCategories());
    }
    public function getUsedCategories()
    {
        include 'database_controller.php';
        $country = $_POST['country'];
        $city = $_POST['city'];
        echo json_encode((new DatabaseController)->getUsedCategories($country, $city));
    }
}
?>