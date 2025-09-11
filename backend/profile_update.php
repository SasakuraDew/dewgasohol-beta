<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

require '../connectdb.php';

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->id) || !isset($data->fullname) || !isset($data->display_name)) {
    http_response_code(400);
    echo json_encode(['status' => 'error', 'message' => 'Incomplete data provided']);
    exit;
}

$id = $data->id;
$fullname = $data->fullname;
$display_name = $data->display_name;
// Use null coalescing operator for optional fields
$phone = $data->phone ?? null;
$address = $data->address ?? null;

try {
    // Note: This assumes your 'users' table has columns 'phone' and 'address'.
    // You may need to add them: ALTER TABLE users ADD phone VARCHAR(255), ADD address TEXT;
    $stmt = $conn->prepare("UPDATE users SET fullname = ?, display_name = ?, phone = ?, address = ? WHERE id = ?");
    $stmt->bind_param("ssssi", $fullname, $display_name, $phone, $address, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            http_response_code(200);
            echo json_encode(['status' => 'success', 'message' => 'Profile updated successfully']);
        } else {
            http_response_code(200);
            echo json_encode(['status' => 'info', 'message' => 'No changes were made to the profile']);
        }
    } else {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => 'Failed to update profile: ' . $stmt->error]);
    }

    $stmt->close();
    $conn->close();

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => 'System error: ' . $e->getMessage()]);
}
?>