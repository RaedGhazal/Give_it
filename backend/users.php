<?php

$function = $_POST['function'];

switch ($function) {
    case 'add':
        (new UsersHandler)->addUser();
        break;
    default:
        echo 'wrong function';
}

class UsersHandler
{
    public function addUser()
    {
        include 'database_controller.php';
        $phoneNumber = $_POST['phone_number'];
        $country = $_POST['country'];
        $token = $_POST['token'];
        echo (new DatabaseController)->addUser($phoneNumber,$country,$token) ? 'success' : 'fail';
    }
}
?>