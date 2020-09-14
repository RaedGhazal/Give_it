<?php

$function = "get_all";//$_POST["function"];
$categoryHandler = new CategoryHandler;
switch ($function) {
    case 'get_all':
        $categoryHandler->getAllCategories();
        break;
    default:
        echo 'wrong function !';
}
class CategoryHandler
{

    public function getAllCategories()
    {
        include 'database_controller.php';
        echo (new DatabaseController)->getAllCategories();
    }
    public function getCategoriesByCondition()
    {
        
    }
}
?>