<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

session_start();
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    
    $response = ['success' => false, 'message' => '', 'redirect' => ''];
    
    if (empty($email) || empty($password)) {
        $response['message'] = 'Preencha todos os campos';
        echo json_encode($response);
        exit;
    }
    
    $conn = getConnection();
    if (!$conn) {
        $response['message'] = 'Erro de conexão com o banco de dados';
        echo json_encode($response);
        exit;
    }
    
    try {
        $query = "SELECT id, name, email, password FROM users WHERE email = :email";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        
        if ($stmt->rowCount() > 0) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if (password_verify($password, $user['password'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['user_name'] = $user['name'];
                $_SESSION['user_email'] = $user['email'];
                
                $response['success'] = true;
                $response['message'] = 'Login realizado com sucesso!';
                $response['redirect'] = 'pagina2.html';
            } else {
                $response['message'] = 'Senha incorreta';
            }
        } else {
            $response['message'] = 'Email não encontrado';
        }
    } catch(PDOException $e) {
        $response['message'] = 'Erro no servidor. Tente novamente.';
    }
    
    echo json_encode($response);
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método não permitido']);
}
?>