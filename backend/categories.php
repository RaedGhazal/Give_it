<?php

$function = $_POST["function"];
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
        return (new DatabaseController)->getAllCategories();
    }
}
?>