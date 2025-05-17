<?php
header('Content-Type: application/json');
$input = json_decode(file_get_contents('php://input'), true);
if (!empty($input['username']) && !empty($input['password'])) {
    echo json_encode(['message' => 'OK']);
} else {
    echo json_encode(['message' => 'Error']);
}
?>