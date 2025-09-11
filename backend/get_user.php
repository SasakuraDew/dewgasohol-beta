<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

session_start();

require '../connectdb.php';

if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(['status' => 'error', 'message' => 'User ID is required']);
    exit;
}

$userId = $_GET['id'];

try {
    // Note: This assumes your 'users' table has columns 'phone' and 'address'.
    // You may need to add them: ALTER TABLE users ADD phone VARCHAR(255), ADD address TEXT;
    $stmt = $conn->prepare("SELECT id, fullname, display_name, email, position, phone, address FROM users WHERE id = ?");
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        http_response_code(200);
        echo json_encode(['status' => 'success', 'user' => $user]);
    } else {
        http_response_code(404);
        echo json_encode(['status' => 'error', 'message' => 'User not found']);
    }

    $stmt->close();
    $conn->close();

} catch (Exception $e) {
    http_response_code(500);
    // Return the actual error for debugging, but you might want to log it and return a generic error in production.
    echo json_encode(['status' => 'error', 'message' => 'System error: ' . $e->getMessage()]);
}
?>