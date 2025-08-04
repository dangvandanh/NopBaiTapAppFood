CREATE DATABASE app_food;

USE app_food;

-- Bảng người dùng
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(255)
);

-- Bảng nhà hàng
CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resName VARCHAR(255)
);

-- Bảng like nhà hàng
CREATE TABLE likes (
    userId INT,
    resId INT,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (resId) REFERENCES restaurants(id)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    FOREIGN KEY (userId) REFERENCES users(id)
);

-- Bảng đánh giá
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    resId INT,
    content TEXT,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (resId) REFERENCES restaurants(id)
);

-- a.Tìm 5 người đã like nhà hàng nhiều nhất
SELECT
    u.id,
    u.fullName,
    COUNT(*) AS so_luot_like
FROM
    likes l
    JOIN users u ON l.userId = u.id
GROUP BY
    u.id
ORDER BY
    so_luot_like DESC
LIMIT
    5;

-- b.Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT
    r.id,
    r.resName,
    COUNT(*) AS so_luot_like
FROM
    likes l
    JOIN restaurants r ON l.resId = r.id
GROUP BY
    r.id
ORDER BY
    so_luot_like DESC
LIMIT
    2;

-- c.Tìm người đã đặt hàng nhiều nhất
SELECT
    u.id,
    u.fullName,
    COUNT(*) AS so_don_dat
FROM
    orders o
    JOIN users u ON o.userId = u.id
GROUP BY
    u.id
ORDER BY
    so_don_dat DESC
LIMIT
    1;

--d.Tìm người dùng không hoạt động trong hệ thống (không like, không order, không đánh giá)
SELECT
    u.id,
    u.fullName
FROM
    users u
    LEFT JOIN orders o ON u.id = o.userId
    LEFT JOIN likes l ON u.id = l.userId
    LEFT JOIN reviews r ON u.id = r.userId
WHERE
    o.userId IS NULL
    AND l.userId IS NULL
    AND r.userId IS NULL;