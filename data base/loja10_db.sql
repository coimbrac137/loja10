-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/04/2026 às 04:08
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `loja10_db`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','shipped','delivered','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `discount` int(11) DEFAULT 0,
  `image_emoji` varchar(10) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `sold` varchar(50) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `featured` tinyint(1) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `original_price`, `discount`, `image_emoji`, `category`, `sold`, `stock`, `featured`, `status`, `created_at`) VALUES
(1, 'KIT lili creme e perfume 350ml acetinado corpo e...', NULL, 23.15, 35.90, 35, '🧴', 'descobrir', '6mil+', 100, 1, 'active', '2026-04-13 01:39:01'),
(2, 'Almofada Bebê Cercadinho Assento Antiqueda Infantil...', NULL, 136.80, 189.90, 28, '🛋️', 'descobrir', '2mil+', 50, 1, 'active', '2026-04-13 01:39:01'),
(3, 'Calça Cargo feminina Jeans Grafite Super...', NULL, 59.70, 129.90, 54, '👖', 'descobrir', '10mil+', 80, 1, 'active', '2026-04-13 01:39:01'),
(4, 'Cadeira de Escritório Secretária Presidente Me...', NULL, 190.00, 399.00, 52, '💺', 'descobrir', '1mil+', 30, 1, 'active', '2026-04-13 01:39:01'),
(5, 'Garrafa Térmica De Água 500ml Inox', NULL, 39.90, 79.90, 50, '🧊', 'descobrir', '15mil+', 200, 1, 'active', '2026-04-13 01:39:01'),
(6, 'Pijama Feminino Conjunto Moletom', NULL, 69.90, 149.90, 53, '👗', 'descobrir', '8.5mil+', 120, 1, 'active', '2026-04-13 01:39:01'),
(7, 'Short Para Academia Feminino', NULL, 29.90, 79.90, 63, '🩳', 'descobrir', '18mil+', 150, 1, 'active', '2026-04-13 01:39:01'),
(8, 'Par De Aliança Casamento Prata', NULL, 89.90, 199.90, 55, '💍', 'descobrir', '5.2mil+', 60, 1, 'active', '2026-04-13 01:39:01'),
(9, 'Smart TV 43\" Britânia HDR10 Dolby Audio', NULL, 1287.08, 2199.00, 41, '📺', 'eletronicos', '446', 25, 1, 'active', '2026-04-13 01:39:01'),
(10, 'Notebook Lenovo Thinkpad T495 Ryzen 5 Pro', NULL, 1793.41, 3499.00, 49, '💻', 'eletronicos', '205', 15, 1, 'active', '2026-04-13 01:39:01'),
(11, 'Sony Playstation 4 500gb Ps4 Slim + Ea Fc', NULL, 2299.00, 2999.00, 23, '🎮', 'eletronicos', '1.2mil+', 10, 1, 'active', '2026-04-13 01:39:01'),
(12, 'Apple iPhone 13 Branco 128gb Vitrine Grade A', NULL, 3299.00, 5299.00, 38, '📱', 'eletronicos', '856', 8, 1, 'active', '2026-04-13 01:39:01'),
(13, 'Cpu Gamer Barato i5 4gb Ssd 240gb Wifi', NULL, 1899.00, 2499.00, 24, '🖥️', 'eletronicos', '324', 12, 1, 'active', '2026-04-13 01:39:01'),
(14, 'Fone Sem Fio Bluetooth Estéreo', NULL, 49.90, 129.90, 62, '🎧', 'eletronicos', '22mil+', 300, 1, 'active', '2026-04-13 01:39:01'),
(15, 'Mouse Gamer RGB 7 Botões', NULL, 79.90, 159.90, 50, '🖱️', 'eletronicos', '3.2mil+', 180, 1, 'active', '2026-04-13 01:39:01'),
(16, 'Teclado Mecânico Rainbow', NULL, 149.90, 299.90, 50, '⌨️', 'eletronicos', '2.1mil+', 95, 1, 'active', '2026-04-13 01:39:01'),
(17, 'Monitor 24\" Curvo 144hz', NULL, 899.00, 1499.00, 40, '🖥️', 'eletronicos', '978', 20, 1, 'active', '2026-04-13 01:39:01'),
(18, 'Cadeira Gamer Reclinável', NULL, 699.00, 1299.00, 46, '💺', 'eletronicos', '1.5mil+', 35, 1, 'active', '2026-04-13 01:39:01'),
(19, 'Mesa Digitalizadora Desenho', NULL, 249.90, 499.90, 50, '📝', 'eletronicos', '876', 42, 1, 'active', '2026-04-13 01:39:01'),
(20, 'Smartwatch Pro Ultra 8', NULL, 199.90, 399.90, 50, '⌚', 'eletronicos', '4.2mil+', 110, 1, 'active', '2026-04-13 01:39:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Usuário Demo', 'demo@loja10.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2026-04-13 01:39:01', '2026-04-13 01:39:01');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Índices de tabela `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Índices de tabela `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
