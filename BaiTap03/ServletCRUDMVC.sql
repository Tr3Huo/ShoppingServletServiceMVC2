-- ==========================================================
-- SCRIPT TAO DATABASE VA BANG CHO DU AN ShoppingServletServiceMVC2
-- ==========================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ServletCRUDMVC')
BEGIN
    CREATE DATABASE ServletCRUDMVC;
END
GO

USE ServletCRUDMVC;
GO

-- 1. BANG CATEGORIES (Danh muc san pham)
IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL
    DROP TABLE dbo.categories;
GO

CREATE TABLE categories (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NOT NULL,
    images NVARCHAR(255) NULL,
    status INT DEFAULT 1
);
GO

-- 2. BANG USERS (Nguoi dung)
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) NULL,
    password VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    fullname NVARCHAR(255) NULL,
    roleid INT DEFAULT 3,      -- 1: Admin, 2: Manager, 3: User
    phone VARCHAR(20) NULL,
    status INT DEFAULT 1,      -- 1: Da kich hoat, 0: Chua kich hoat (cho xac thuc OTP)
    code VARCHAR(50) NULL      -- Ma OTP kich hoat hoac quen mat khau
);
GO

-- 3. BANG PRODUCTS (San pham voi moi lien he 1 - n voi categories)
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL
    DROP TABLE dbo.products;
GO

CREATE TABLE products (
    productId INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    quantity INT DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    images NVARCHAR(255) NULL,
    status INT DEFAULT 1,
    createdDate DATETIME DEFAULT GETDATE(),
    categoryId INT FOREIGN KEY REFERENCES categories(categoryId) ON DELETE SET NULL
);
GO

-- 4. THEM DU LIEU MAU
-- Tai khoan Admin mac dinh (admin / 123)
INSERT INTO users (username, password, email, fullname, roleid, phone, status)
VALUES ('admin', '123', 'admin@gmail.com', N'Quản Trị Viên', 1, '0987654321', 1);

-- Danh muc mau
INSERT INTO categories (categoryname, images, status) VALUES 
(N'Điện thoại & Tablet', 'avatar.png', 1),
(N'Laptop & Máy tính', 'avatar.png', 1),
(N'Phụ kiện công nghệ', 'avatar.png', 1),
(N'Đồng hồ thông minh', 'avatar.png', 1);

-- 10 san pham mau de test ngay tinh nang Top 10 va phan trang 6sp/trang
INSERT INTO products (productName, price, quantity, description, images, status, createdDate, categoryId) VALUES
(N'iPhone 15 Pro Max 256GB', 31990000, 20, N'Thiết kế khung Titan chuẩn hàng không vũ trụ, chip A17 Pro mạnh mẽ nhất thế giới.', NULL, 1, DATEADD(minute, -10, GETDATE()), 1),
(N'Samsung Galaxy S24 Ultra', 28990000, 15, N'Điện thoại AI thông minh đầu tiên, camera 200MP, bút S-Pen quyền năng.', NULL, 1, DATEADD(minute, -9, GETDATE()), 1),
(N'MacBook Pro 14 M3 Pro', 49990000, 10, N'Màn hình Liquid Retina XDR cực đẹp, pin lên đến 22 giờ, sức mạnh đột phá.', NULL, 1, DATEADD(minute, -8, GETDATE()), 2),
(N'Laptop ASUS ROG Zephyrus G16', 42990000, 8, N'Laptop gaming mỏng nhẹ cao cấp, màn hình OLED 240Hz, card RTX 4070.', NULL, 1, DATEADD(minute, -7, GETDATE()), 2),
(N'Apple Watch Ultra 2 GPS + Cellular', 21490000, 12, N'Mặt kính Sapphire, vỏ Titan 49mm, thời lượng pin ấn tượng, chuẩn thể thao chuyên nghiệp.', NULL, 1, DATEADD(minute, -6, GETDATE()), 4),
(N'Tai nghe Sony WH-1000XM5', 6990000, 30, N'Chống ồn đỉnh cao, chất âm trung thực, đàm thoại cực rõ, thiết kế thời thượng.', NULL, 1, DATEADD(minute, -5, GETDATE()), 3),
(N'iPad Pro 11 M4 Wifi 256GB', 27990000, 18, N'Độ mỏng kỷ lục thế giới 5.1mm, chip M4 siêu khủng, màn hình Ultra Retina XDR Tandem OLED.', NULL, 1, DATEADD(minute, -4, GETDATE()), 1),
(N'Bàn phím cơ Keychron Q1 Pro', 4290000, 25, N'Thiết kế nhôm CNC, kết nối không dây Bluetooth 5.1, switch cơ học gõ cực êm.', NULL, 1, DATEADD(minute, -3, GETDATE()), 3),
(N'Chuột Logitech MX Master 3S', 2190000, 40, N'Cảm biến 8000 DPI, nút bấm tĩnh âm Silent Clicks, con lăn MagSpeed siêu tốc.', NULL, 1, DATEADD(minute, -2, GETDATE()), 3),
(N'Đồng hồ Samsung Galaxy Watch 6', 5490000, 22, N'Theo dõi sức khỏe toàn diện, đo điện tâm đồ ECG, viền xoay bezel cổ điển tinh tế.', NULL, 1, DATEADD(minute, -1, GETDATE()), 4),
(N'Tai nghe AirPods Pro 2 USB-C', 5690000, 35, N'Chip H2 nâng cấp, chống ồn chủ động gấp 2 lần, hộp sạc MagSafe cổng Type-C.', NULL, 1, GETDATE(), 3);
GO