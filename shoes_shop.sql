-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 25 2026 г., 20:16
-- Версия сервера: 8.0.30
-- Версия PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `shoes_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'Женская обувь'),
(2, 'Мужская обувь');

-- --------------------------------------------------------

--
-- Структура таблицы `manufactures`
--

CREATE TABLE `manufactures` (
  `manufacture_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `manufactures`
--

INSERT INTO `manufactures` (`manufacture_id`, `name`) VALUES
(1, 'Kari'),
(2, 'Marco Tozzi'),
(3, 'Рос'),
(4, 'Rieker'),
(5, 'Alessio Nesca'),
(6, 'CROSBY');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `order_date` date NOT NULL,
  `delivery_date` date NOT NULL,
  `point_address_id` int NOT NULL,
  `client_id` int NOT NULL,
  `code_to_take` varchar(64) NOT NULL,
  `status_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`order_id`, `order_date`, `delivery_date`, `point_address_id`, `client_id`, `code_to_take`, `status_id`) VALUES
(1, '2025-02-27', '2025-04-20', 1, 4, '901', 1),
(2, '2022-09-28', '2025-04-21', 11, 1, '902', 1),
(3, '2025-03-21', '2025-04-22', 2, 2, '903', 1),
(4, '2025-02-20', '2025-04-23', 11, 3, '904', 1),
(5, '2025-03-17', '2025-04-24', 2, 4, '905', 1),
(6, '2025-03-01', '2025-04-25', 15, 1, '906', 1),
(7, '2025-02-28', '2025-04-26', 3, 2, '907', 1),
(8, '2025-03-31', '2025-04-27', 19, 3, '908', 2),
(9, '2025-04-02', '2025-04-02', 5, 4, '909', 1),
(10, '2025-04-03', '2025-04-29', 19, 4, '910', 2),
(12, '2000-01-01', '2000-01-01', 1, 1, '966', 1),
(13, '2000-01-01', '2000-01-01', 1, 1, '931', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `order_products`
--

CREATE TABLE `order_products` (
  `line_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `amount` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `order_products`
--

INSERT INTO `order_products` (`line_id`, `order_id`, `product_id`, `amount`) VALUES
(1, 1, 1, 2),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 2, 4, 1),
(5, 3, 5, 10),
(6, 3, 6, 10),
(7, 4, 7, 5),
(8, 4, 8, 4),
(9, 5, 1, 2),
(10, 5, 2, 2),
(11, 6, 3, 1),
(12, 6, 4, 1),
(13, 7, 5, 10),
(14, 7, 6, 10),
(15, 8, 7, 5),
(16, 8, 8, 4),
(17, 9, 9, 5),
(18, 9, 10, 1),
(19, 10, 11, 5),
(20, 10, 12, 5),
(21, 13, 32, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `pick_up_points`
--

CREATE TABLE `pick_up_points` (
  `point_id` int NOT NULL,
  `address` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `pick_up_points`
--

INSERT INTO `pick_up_points` (`point_id`, `address`) VALUES
(1, '420151, г. Лесной, ул. Вишневая, 32'),
(2, '125061, г. Лесной, ул. Подгорная, 8'),
(3, '630370, г. Лесной, ул. Шоссейная, 24'),
(4, '400562, г. Лесной, ул. Зеленая, 32'),
(5, '614510, г. Лесной, ул. Маяковского, 47'),
(6, '410542, г. Лесной, ул. Светлая, 46'),
(7, '620839, г. Лесной, ул. Цветочная, 8'),
(8, '443890, г. Лесной, ул. Коммунистическая, 1'),
(9, '603379, г. Лесной, ул. Спортивная, 46'),
(10, '603721, г. Лесной, ул. Гоголя, 41'),
(11, '410172, г. Лесной, ул. Северная, 13'),
(12, '614611, г. Лесной, ул. Молодежная, 50'),
(13, '454311, г.Лесной, ул. Новая, 19'),
(14, '660007, г.Лесной, ул. Октябрьская, 19'),
(15, '603036, г. Лесной, ул. Садовая, 4'),
(16, '394060, г.Лесной, ул. Фрунзе, 43'),
(17, '410661, г. Лесной, ул. Школьная, 50'),
(18, '625590, г. Лесной, ул. Коммунистическая, 20'),
(19, '625683, г. Лесной, ул. 8 Марта'),
(20, '450983, г.Лесной, ул. Комсомольская, 26'),
(21, '394782, г. Лесной, ул. Чехова, 3'),
(22, '603002, г. Лесной, ул. Дзержинского, 28'),
(23, '450558, г. Лесной, ул. Набережная, 30'),
(24, '344288, г. Лесной, ул. Чехова, 1'),
(25, '614164, г.Лесной,  ул. Степная, 30'),
(26, '394242, г. Лесной, ул. Коммунистическая, 43'),
(27, '660540, г. Лесной, ул. Солнечная, 25'),
(28, '125837, г. Лесной, ул. Шоссейная, 40'),
(29, '125703, г. Лесной, ул. Партизанская, 49'),
(30, '625283, г. Лесной, ул. Победы, 46'),
(31, '614753, г. Лесной, ул. Полевая, 35'),
(32, '426030, г. Лесной, ул. Маяковского, 44'),
(33, '450375, г. Лесной ул. Клубная, 44'),
(34, '625560, г. Лесной, ул. Некрасова, 12'),
(35, '630201, г. Лесной, ул. Комсомольская, 17'),
(36, '190949, г. Лесной, ул. Мичурина, 26');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `article` varchar(12) NOT NULL,
  `category_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `manufacturer_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `measure_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `description` varchar(256) NOT NULL,
  `pic` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`product_id`, `article`, `category_id`, `supplier_id`, `manufacturer_id`, `name`, `measure_type`, `price`, `discount`, `quantity`, `description`, `pic`) VALUES
(1, 'А112Т4', 1, 1, 1, 'Ботинки', 'шт.', '4990.00', '3.00', 6, 'Женские Ботинки демисезонные kari', '1.jpg'),
(2, 'F635R4', 1, 2, 2, 'Ботинки', 'шт.', '3244.00', '2.00', 13, 'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый', '2.jpg'),
(3, 'H782T5', 2, 1, 1, 'Туфли', 'шт.', '4499.00', '4.00', 5, 'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный', '3.jpg'),
(4, 'G783F5', 2, 1, 3, 'Ботинки', 'шт.', '5900.00', '2.00', 8, 'Мужские ботинки Рос-Обувь кожаные с натуральным мехом', '4.jpg'),
(5, 'J384T6', 2, 2, 4, 'Ботинки', 'шт.', '3800.00', '2.00', 16, 'B3430/14 Полуботинки мужские Rieker', '5.jpg'),
(6, 'D572U8', 2, 2, 3, 'Кроссовки', 'шт.', '4100.00', '3.00', 6, '129615-4 Кроссовки мужские', '6.jpg'),
(7, 'F572H7', 1, 1, 2, 'Туфли', 'шт.', '2700.00', '2.00', 14, 'Туфли Marco Tozzi женские летние, размер 39, цвет черный', '7.jpg'),
(8, 'D329H3', 1, 2, 5, 'Полуботинки', 'шт.', '1890.00', '4.00', 4, 'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый', '8.jpg'),
(9, 'B320R5', 1, 1, 4, 'Туфли', 'шт.', '4300.00', '2.00', 6, 'Туфли Rieker женские демисезонные, размер 41, цвет коричневый', '9.jpg'),
(10, 'G432E4', 1, 1, 1, 'Туфли', 'шт.', '2800.00', '3.00', 15, 'Туфли kari женские TR-YR-413017, размер 37, цвет: черный', '10.jpg'),
(11, 'S213E3', 2, 2, 6, 'Полуботинки', 'шт.', '2156.00', '3.00', 6, '407700/01-01 Полуботинки мужские CROSBY', ''),
(12, 'E482R4', 1, 1, 1, 'Полуботинки', 'шт.', '1800.00', '2.00', 14, 'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный', ''),
(13, 'S634B5', 2, 2, 6, 'Кеды', 'шт.', '5500.00', '3.00', 0, 'Кеды Caprice мужские демисезонные, размер 42, цвет черный', ''),
(14, 'K345R4', 2, 2, 6, 'Полуботинки', 'шт.', '2100.00', '2.00', 3, '407700/01-02 Полуботинки мужские CROSBY', ''),
(15, 'O754F4', 1, 2, 4, 'Туфли', 'шт.', '5400.00', '4.00', 18, 'Туфли женские демисезонные Rieker артикул 55073-68/37', ''),
(16, 'G531F4', 1, 1, 1, 'Ботинки', 'шт.', '6600.00', '12.00', 9, 'Ботинки женские зимние ROMER арт. 893167-01 Черный', ''),
(17, 'J542F5', 2, 1, 1, 'Тапочки', 'шт.', '500.00', '13.00', 0, 'Тапочки мужские Арт.70701-55-67син р.41', ''),
(18, 'B431R5', 2, 2, 4, 'Ботинки', 'шт.', '2700.00', '2.00', 5, 'Мужские кожаные ботинки/мужские ботинки', ''),
(19, 'P764G4', 1, 1, 6, 'Туфли', 'шт.', '6800.00', '15.00', 15, 'Туфли женские, ARGO, размер 38', 'picture.png'),
(20, 'C436G5', 1, 1, 5, 'Ботинки', 'шт.', '10200.00', '15.00', 9, 'Ботинки женские, ARGO, размер 40', 'picture.png'),
(21, 'F427R5', 1, 2, 4, 'Ботинки', 'шт.', '11800.00', '15.00', 11, 'Ботинки на молнии с декоративной пряжкой FRAU', 'picture.png'),
(22, 'N457T5', 1, 1, 6, 'Полуботинки', 'шт.', '4600.00', '3.00', 13, 'Полуботинки Ботинки черные зимние, мех', 'picture.png'),
(23, 'D364R4', 1, 1, 1, 'Туфли', 'шт.', '12400.00', '16.00', 5, 'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши', 'picture.png'),
(24, 'S326R5', 2, 2, 6, 'Тапочки', 'шт.', '9900.00', '17.00', 15, 'Мужские кожаные тапочки \"Профиль С.Дали\"', 'picture.png'),
(25, 'L754R4', 1, 1, 1, 'Полуботинки', 'шт.', '1700.00', '2.00', 7, 'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный', 'picture.png'),
(26, 'M542T5', 2, 2, 4, 'Кроссовки', 'шт.', '2800.00', '18.00', 3, 'Кроссовки мужские TOFA', 'picture.png'),
(27, 'D268G5', 1, 2, 4, 'Туфли', 'шт.', '4399.00', '3.00', 12, 'Туфли Rieker женские демисезонные, размер 36, цвет коричневый', 'picture.png'),
(28, 'T324F5', 1, 1, 6, 'Сапоги', 'шт.', '4699.00', '2.00', 5, 'Сапоги замша Цвет: синий', 'picture.png'),
(29, 'K358H6', 2, 1, 4, 'Тапочки', 'шт.', '599.00', '20.00', 2, 'Тапочки мужские син р.41', 'picture.png'),
(30, 'H535R5', 1, 2, 4, 'Ботинки', 'шт.', '2300.00', '2.00', 7, 'Женские Ботинки демисезонные', 'picture.png'),
(32, 'A123', 1, 1, 1, 'ТУФЛИ', 'шт.', '23.00', '23.00', 23, 'Туфли мега мега', 'picture.png');

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `role_id` int NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`role_id`, `name`) VALUES
(1, 'Администратор'),
(2, 'Менеджер'),
(3, 'Авторизированный клиент');

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `status_id` int NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`status_id`, `name`) VALUES
(1, 'Завершен'),
(2, 'Новый ');

-- --------------------------------------------------------

--
-- Структура таблицы `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`) VALUES
(1, 'Kari'),
(2, 'Обувь для вас');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `login` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `role_id`, `name`, `surname`, `last_name`, `login`, `password_hash`) VALUES
(1, 1, 'Никифорова', 'Весения', 'Николаевна', 'admin', 'admin123'),
(2, 1, 'Сазонов', 'Руслан', 'Германович', 'uth4iz@mail.com', '2L6KZG'),
(3, 1, 'Одинцов', 'Серафим', 'Артёмович', 'yzls62@outlook.com', 'JlFRCZ'),
(4, 2, 'Степанов', 'Михаил', 'Артёмович', 'manager', 'manager123'),
(5, 2, 'Ворсин', 'Петр', 'Евгеньевич', 'tjde7c@yahoo.com', 'YOyhfR'),
(6, 2, 'Старикова', 'Елена', 'Павловна', 'wpmrc3do@tutanota.com', 'RSbvHv'),
(7, 3, 'Михайлюк', 'Анна', 'Вячеславовна', 'client', 'client123'),
(8, 3, 'Ситдикова', 'Елена', 'Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos'),
(9, 3, 'Ворсин', 'Петр', 'Евгеньевич', '1qz4kw@mail.com', 'gynQMT'),
(10, 3, 'Старикова', 'Елена', 'Павловна', '4np6se@mail.com', 'AtnDjr');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Индексы таблицы `manufactures`
--
ALTER TABLE `manufactures`
  ADD PRIMARY KEY (`manufacture_id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_code` (`code_to_take`),
  ADD KEY `point_address_id` (`point_address_id`),
  ADD KEY `client_id` (`client_id`,`status_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Индексы таблицы `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`line_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `pick_up_points`
--
ALTER TABLE `pick_up_points`
  ADD PRIMARY KEY (`point_id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_article` (`article`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `supplier_id` (`supplier_id`,`manufacturer_id`),
  ADD KEY `manufacturer_id` (`manufacturer_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Индексы таблицы `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`status_id`);

--
-- Индексы таблицы `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `manufactures`
--
ALTER TABLE `manufactures`
  MODIFY `manufacture_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `order_products`
--
ALTER TABLE `order_products`
  MODIFY `line_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `pick_up_points`
--
ALTER TABLE `pick_up_points`
  MODIFY `point_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `statuses`
--
ALTER TABLE `statuses`
  MODIFY `status_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`point_address_id`) REFERENCES `pick_up_points` (`point_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`status_id`);

--
-- Ограничения внешнего ключа таблицы `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufactures` (`manufacture_id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
