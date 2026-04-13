<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';
    
    $response = ['success' => false, 'message' => ''];
    
    // Validações
    if (empty($name) || empty($email) || empty($password)) {
        $response['message'] = 'Preencha todos os campos';
        echo json_encode($response);
        exit;
    }
    
    if (strlen($name) < 3) {
        $response['message'] = 'Nome deve ter pelo menos 3 caracteres';
        echo json_encode($response);
        exit;
    }
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $response['message'] = 'Email inválido';
        echo json_encode($response);
        exit;
    }
    
    if (strlen($password) < 6) {
        $response['message'] = 'Senha deve ter no mínimo 6 caracteres';
        echo json_encode($response);
        exit;
    }
    
    if ($password !== $confirm_password) {
        $response['message'] = 'As senhas não coincidem';
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
        // Verificar se email já existe
        $checkQuery = "SELECT id FROM users WHERE email = :email";
        $checkStmt = $conn->prepare($checkQuery);
        $checkStmt->bindParam(':email', $email);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() > 0) {
            $response['message'] = 'Email já cadastrado';
            echo json_encode($response);
            exit;
        }
        
        // Criar usuário
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);
        $query = "INSERT INTO users (name, email, password) VALUES (:name, :email, :password)";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $hashed_password);
        
        if ($stmt->execute()) {
            $response['success'] = true;
            $response['message'] = 'Cadastro realizado com sucesso!';
        } else {
            $response['message'] = 'Erro ao cadastrar. Tente novamente.';
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