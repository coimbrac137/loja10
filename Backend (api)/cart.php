<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

session_start();
require_once 'config/database.php';

// Verificar se usuário está logado
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Usuário não autenticado']);
    exit;
}

$user_id = $_SESSION['user_id'];
$database = new Database();
$db = $database->getConnection();

// GET - Buscar carrinho
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $query = "SELECT c.*, p.name, p.price, p.image_emoji FROM cart c 
              JOIN products p ON c.product_id = p.id 
              WHERE c.user_id = :user_id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':user_id', $user_id);
    $stmt->execute();
    
    $cart = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $total = 0;
    
    foreach ($cart as $item) {
        $total += $item['price'] * $item['quantity'];
    }
    
    echo json_encode(['success' => true, 'cart' => $cart, 'total' => $total]);
}

// POST - Adicionar ao carrinho
elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $product_id = $data['product_id'] ?? 0;
    $quantity = $data['quantity'] ?? 1;
    
    // Verificar se produto já está no carrinho
    $checkQuery = "SELECT id, quantity FROM cart WHERE user_id = :user_id AND product_id = :product_id";
    $checkStmt = $db->prepare($checkQuery);
    $checkStmt->bindParam(':user_id', $user_id);
    $checkStmt->bindParam(':product_id', $product_id);
    $checkStmt->execute();
    
    if ($checkStmt->rowCount() > 0) {
        // Atualizar quantidade
        $cartItem = $checkStmt->fetch(PDO::FETCH_ASSOC);
        $newQuantity = $cartItem['quantity'] + $quantity;
        
        $updateQuery = "UPDATE cart SET quantity = :quantity WHERE id = :id";
        $updateStmt = $db->prepare($updateQuery);
        $updateStmt->bindParam(':quantity', $newQuantity);
        $updateStmt->bindParam(':id', $cartItem['id']);
        
        if ($updateStmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Produto atualizado no carrinho']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Erro ao atualizar carrinho']);
        }
    } else {
        // Adicionar novo item
        $insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (:user_id, :product_id, :quantity)";
        $insertStmt = $db->prepare($insertQuery);
        $insertStmt->bindParam(':user_id', $user_id);
        $insertStmt->bindParam(':product_id', $product_id);
        $insertStmt->bindParam(':quantity', $quantity);
        
        if ($insertStmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Produto adicionado ao carrinho']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Erro ao adicionar ao carrinho']);
        }
    }
}

// DELETE - Remover do carrinho
elseif ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $data = json_decode(file_get_contents('php://input'), true);
    $cart_id = $data['cart_id'] ?? 0;
    
    $query = "DELETE FROM cart WHERE id = :id AND user_id = :user_id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':id', $cart_id);
    $stmt->bindParam(':user_id', $user_id);
    
    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Produto removido do carrinho']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Erro ao remover produto']);
    }
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método não permitido']);
}
?>