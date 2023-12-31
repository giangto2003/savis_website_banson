﻿-- Tạo Database
IF OBJECT_ID('BanSon') IS NOT NULL
	DROP DATABASE BanSon
GO
CREATE DATABASE BanSon
GO
-- Sử dụng database
USE BanSon
GO

--Tạo bảng Thương hiệu (Brand)
IF OBJECT_ID('Brand') IS NOT NULL
	DROP TABLE Brand
GO
CREATE TABLE Brand (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
	Image NVARCHAR(MAX),
	Status INT NOT NULL,
);

-- Tạo bảng Sản phẩm (Product)
IF OBJECT_ID('Product') IS NOT NULL
	DROP TABLE Product
GO
CREATE TABLE Product (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(255) NOT NULL,
	AvailableQuantity INT NOT NULL,
	Sold INT NOT NULL,
	Likes INT NOT NULL,
	CreatedDate DATE NOT NULL,
	Status INT NOT NULL,
    Description NVARCHAR(MAX),
    BrandId UNIQUEIDENTIFIER,
    FOREIGN KEY (BrandId) REFERENCES Brand(Id),
);

--Tạo bảng Danh mục (Category)
IF OBJECT_ID('Category') IS NOT NULL
	DROP TABLE Category
GO
CREATE TABLE Category (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
	Status INT NOT NULL,
);

--Tạo bảng Chi tiết Danh mục (CategoryDetail)
IF OBJECT_ID('CategoryDetail') IS NOT NULL
	DROP TABLE CategoryDetail
GO
CREATE TABLE CategoryDetail (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Quantity INT NOT NULL,
    ProductId UNIQUEIDENTIFIER,
    CategoryId UNIQUEIDENTIFIER,
    FOREIGN KEY (ProductId) REFERENCES Product(Id),
    FOREIGN KEY (CategoryId) REFERENCES Category(Id),
);

--Tạo bảng Màu sắc (Color)
IF OBJECT_ID('Color') IS NOT NULL
	DROP TABLE Color
GO
CREATE TABLE Color (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Image NVARCHAR(MAX) NOT NULL,
	Status INT NOT NULL,
    BrandId UNIQUEIDENTIFIER,
    FOREIGN KEY (BrandId) REFERENCES Brand(Id),
);

-- Tạo bảng Chi tiết Sản phẩm (ProductDetail)
IF OBJECT_ID('ProductDetail') IS NOT NULL
	DROP TABLE ProductDetail
GO
CREATE TABLE ProductDetail (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	ImportPrice DECIMAL(10, 2) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
	Quantity INT NOT NULL,
	CreatedDate DATE NOT NULL,
	Status INT NOT NULL,
    Description NVARCHAR(MAX),
    ProductId UNIQUEIDENTIFIER,
    ColorId UNIQUEIDENTIFIER,
    FOREIGN KEY (ProductId) REFERENCES Product(Id),
    FOREIGN KEY (ColorId) REFERENCES Color(Id),
);

-- Tạo bảng Hình ảnh Sản phẩm (ProductImage)
IF OBJECT_ID('ProductImage') IS NOT NULL
	DROP TABLE ProductImage
GO
CREATE TABLE ProductImage (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(MAX) NOT NULL,
	Status INT NOT NULL,
    ProductDetailId UNIQUEIDENTIFIER,
    FOREIGN KEY (ProductDetailId) REFERENCES ProductDetail(Id),
);

-- Tạo bảng Khách hàng (Customer)
IF OBJECT_ID('Customer') IS NOT NULL
	DROP TABLE Customer
GO
CREATE TABLE Customer (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
	Gender INT NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
	CreatedDate DATE NOT NULL, 
    Address NVARCHAR(MAX),
    Status INT NOT NULL,
);

-- Tạo bảng Danh sách Yêu Thích (WishList)
IF OBJECT_ID('WishList') IS NOT NULL
	DROP TABLE WishList
GO
CREATE TABLE WishList (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ProductId UNIQUEIDENTIFIER,
    CustomerId UNIQUEIDENTIFIER,
    FOREIGN KEY (ProductId) REFERENCES Product(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
);

-- Tạo bảng Giỏ hàng (Cart)
IF OBJECT_ID('Cart') IS NOT NULL
	DROP TABLE Cart
GO
CREATE TABLE Cart (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Quantity INT NOT NULL,
    TotalMoney DECIMAL(10, 2) NOT NULL,
	Status INT NOT NULL,
    CustomerId UNIQUEIDENTIFIER,
    FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
);

-- Tạo bảng Chi tiết Giỏ hàng (CartDetail)
IF OBJECT_ID('CartDetail') IS NOT NULL
	DROP TABLE CartDetail
GO
CREATE TABLE CartDetail (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CustomerId UNIQUEIDENTIFIER,
    ProductDetailId UNIQUEIDENTIFIER,
    FOREIGN KEY (CustomerId) REFERENCES Cart(Id),
    FOREIGN KEY (ProductDetailId) REFERENCES ProductDetail(Id),
);

-- Tạo bảng Chức vụ (Role)
IF OBJECT_ID('Role') IS NOT NULL
	DROP TABLE Role
GO
CREATE TABLE Role (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(30) NOT NULL,
    Status INT NOT NULL,
);

-- Tạo bảng  (Employee)
IF OBJECT_ID('Employee') IS NOT NULL
	DROP TABLE Employee
GO
CREATE TABLE Employee (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
	Gender INT NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Image NVARCHAR(MAX),
    DateOfBirth DATE NOT NULL,
	CreatedDate DATE NOT NULL, 
    Address NVARCHAR(MAX),
	Status INT NOT NULL,
	RoleId UNIQUEIDENTIFIER,
	FOREIGN KEY (RoleId) REFERENCES Role(Id),
);

-- Tạo bảng Trạng thái Hóa Đơn (BillStatus)
IF OBJECT_ID('BillStatus') IS NOT NULL
	DROP TABLE BillStatus
GO
CREATE TABLE BillStatus (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
	Status INT NOT NULL
);

-- Tạo bảng Phương thức thanh toán (Payment)
IF OBJECT_ID('Payment') IS NOT NULL
	DROP TABLE Payment
GO
CREATE TABLE Payment (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
	Status INT NOT NULL
);

-- Tạo bảng Hóa Đơn (Bill)
IF OBJECT_ID('Bill') IS NOT NULL
	DROP TABLE Bill
GO
CREATE TABLE Bill (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ReceiverName NVARCHAR(100) NOT NULL,
	TotalMoney DECIMAL(10, 2) NOT NULL,
    CustomerPhone NVARCHAR(50) NOT NULL,
	AddressDelivery NVARCHAR(100) NOT NULL,
    CreatedDate DATE NOT NULL,
    BillStatusId UNIQUEIDENTIFIER,
    PaymentId UNIQUEIDENTIFIER,
	EmployeeId UNIQUEIDENTIFIER,
    CustomerId UNIQUEIDENTIFIER,
    FOREIGN KEY (BillStatusId) REFERENCES BillStatus(Id),
    FOREIGN KEY (PaymentId) REFERENCES Payment(Id),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
);

-- Tạo bảng Chi tiết Hóa Đơn (BillDetail)
IF OBJECT_ID('BillDetail') IS NOT NULL
	DROP TABLE BillDetail
GO
CREATE TABLE BillDetail (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Quantity INT NOT NULL,
	Price DECIMAL(10, 2) NOT NULL,
    BillId UNIQUEIDENTIFIER,
    ProductDetailId UNIQUEIDENTIFIER,
    FOREIGN KEY (BillId) REFERENCES Bill(Id),
    FOREIGN KEY (ProductDetailId) REFERENCES ProductDetail(Id),
);

-- Tạo bảng Chi tiết Voucher (Voucher)
IF OBJECT_ID('Voucher') IS NOT NULL
	DROP TABLE Voucher
GO
CREATE TABLE Voucher (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Code NVARCHAR(100) NOT NULL,
	Value DECIMAL(10, 2) NOT NULL,
    TimeStart DATE NOT NULL,
	TimeEnd DATE NOT NULL,
    CreatedDate DATE NOT NULL,
	Status INT NOT NULL,
);

-- Tạo bảng Chi tiết UsedVoucher (UsedVoucher)
IF OBJECT_ID('UsedVoucher') IS NOT NULL
	DROP TABLE UsedVoucher
GO
CREATE TABLE UsedVoucher (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	SubTotal DECIMAL(10, 2) NOT NULL,
    BillId UNIQUEIDENTIFIER,
    VoucherId UNIQUEIDENTIFIER,
    FOREIGN KEY (BillId) REFERENCES Bill(Id),
    FOREIGN KEY (VoucherId) REFERENCES Voucher(Id),
);

--Nhập liệu các bảng

--Nhập dữ liệu bảng Thương hiệu (Brand)
INSERT INTO Brand VALUES
('15333be6-0d95-4b7c-b0e9-ee00c5110101', 'M.A.C', 'mac.png', 0),
('15333be6-0d95-4b7c-b0e9-ee00c5110102', '3CE', '3ce.png', 0),
('15333be6-0d95-4b7c-b0e9-ee00c5110103', 'Dior', 'logo-dior.png', 0),
('15333be6-0d95-4b7c-b0e9-ee00c5110104', 'Bobbi Brown', 'bobbi_brown.png', 0),
('15333be6-0d95-4b7c-b0e9-ee00c5110105', 'Black Rouge', 'Black_Rouge.png', 0)
GO

--Nhập dữ liệu bảng Sản phẩm (Product)
INSERT INTO Product VALUES
('67357ae4-342e-4673-b80f-1f1d1f030c0c', 'Matte Lipstick', 100, 0, 1, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('67357ae4-342e-4673-b80f-1f1d1f020c0c', 'Milk Tea Velvet Tint', 99, 1, 1, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('67357ae4-342e-4673-b80f-1f1d1f010c0c', 'Rouge Dior', 98, 2, 1, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('67357ae4-342e-4673-b80f-1f1d1f000c0c', 'Crushed Oil-Infused Gloss', 100, 0, 1, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('67357ae4-342e-4673-b80f-1f1d1f070c0c', 'Black Rouge Air Fit Velvet Tint Ver 9 Acoustic Mood', 99, 1, 1, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('8958bbdc-bea0-4bb3-96c7-ebc6885f4839', 'Powder Kiss Velvet Blur Slim Stick / Bizarre Blizzard Bash', 100, 0, 0, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('8958bbdc-bea0-4bb3-96c7-ebc6885f4838', 'Blur Water Tint', 99, 1, 0, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('8958bbdc-bea0-4bb3-96c7-ebc6885f4837', 'Dior Addict', 100, 0, 0, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('8958bbdc-bea0-4bb3-96c7-ebc6885f4836', 'Luxe Shine Intense Lipstick', 100, 0, 0, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('8958bbdc-bea0-4bb3-96c7-ebc6885f4835', 'Black Rouge Half N Half Water Glow Season 2', 100, 0, 0, '09/10/2023', 0, '', '15333be6-0d95-4b7c-b0e9-ee00c5110105')
GO

--Nhập dữ liệu bảng Danh mục (Category)
INSERT INTO Category VALUES
('67357ae4-342e-4673-b80f-1f1d1f068c9c', 'Creme Lipstick', 0),
('67357ae4-342e-4673-b80f-1f1d1f068c0c', 'Lip tint', 0),
('67357ae4-342e-4673-b80f-1f1d1f069c0c', 'Matte Lipstick', 0),
('67357ae4-342e-4673-b80f-1f1d1f067c0c', 'Lip Gloss', 0),
('67357ae4-342e-4673-b80f-1f1d1f066c0c', 'Lip Balm', 0),
('67357ae4-342e-4673-b80f-1f1d1f065c0c', 'Pearly/frost lipstick', 0),
('67357ae4-342e-4673-b80f-1f1d1f064c0c', 'Son Satin', 0),
('67357ae4-342e-4673-b80f-1f1d1f063c0c', 'Son Sheer', 0),
('2d31bef4-d3b7-46b4-b963-08463d55d3a8', 'Hydrating Shine Lipstick', 0)
GO

--Nhập dữ liệu bảng Chi tiết Danh mục (CategoryDetail)
INSERT INTO CategoryDetail VALUES
('653ef875-5059-486e-b13d-2cc1b2a78ae1', 4, '67357ae4-342e-4673-b80f-1f1d1f030c0c', '67357ae4-342e-4673-b80f-1f1d1f068c9c'),
('653ef875-5059-486e-b13d-2cc1b2a78ae2', 4, '67357ae4-342e-4673-b80f-1f1d1f020c0c', '67357ae4-342e-4673-b80f-1f1d1f068c0c'),
('653ef875-5059-486e-b13d-2cc1b2a78ae3', 2, '67357ae4-342e-4673-b80f-1f1d1f010c0c', '67357ae4-342e-4673-b80f-1f1d1f069c0c'),
('653ef875-5059-486e-b13d-2cc1b2a78ae4', 1, '67357ae4-342e-4673-b80f-1f1d1f010c0c', '67357ae4-342e-4673-b80f-1f1d1f064c0c'),
('653ef875-5059-486e-b13d-2cc1b2a78ae5', 2, '67357ae4-342e-4673-b80f-1f1d1f000c0c', '67357ae4-342e-4673-b80f-1f1d1f067c0c'),
('653ef875-5059-486e-b13d-2cc1b2a78ae6', 4, '67357ae4-342e-4673-b80f-1f1d1f070c0c', '67357ae4-342e-4673-b80f-1f1d1f068c0c'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c4', 2, '8958bbdc-bea0-4bb3-96c7-ebc6885f4839', '67357ae4-342e-4673-b80f-1f1d1f069c0c'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c5', 1, '8958bbdc-bea0-4bb3-96c7-ebc6885f4839', '67357ae4-342e-4673-b80f-1f1d1f066c0c'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c6', 4, '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '67357ae4-342e-4673-b80f-1f1d1f068c0c'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c7', 2, '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '2d31bef4-d3b7-46b4-b963-08463d55d3a8'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c8', 2, '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '2d31bef4-d3b7-46b4-b963-08463d55d3a8'),
('705abbe1-6072-4d14-abc0-3edc7f9ee4c9', 2, '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '67357ae4-342e-4673-b80f-1f1d1f067c0c')
GO

--Nhập dữ liệu bảng Màu sắc (Color)
INSERT INTO Color VALUES
('67357ae4-342e-4673-b80f-1f1d1f062c0c', 'Sweet Deal', 2, 'MAC_Sweet_Deal.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('67357ae4-342e-4673-b80f-1f1d1f061c0c', 'Kinda Sexy', 2, 'MAC_Kinda_Sexy.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('67357ae4-342e-4673-b80f-1f1d1f060c0c', 'Red Rock', 2, 'MAC_Red_Rock.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('67357ae4-342e-4673-b80f-1f1d1f050c0c', '#05 Vanilla_Tea', 2, '05_Vanilla_Tea.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('67357ae4-342e-4673-b80f-1f1d1f040c0c', '#06 Jasmine Tea', 2, '06_Jasmine_Tea.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('67357ae4-342e-4673-b80f-1f1d1f000c0c', '520 Feel Good satin finish', 2, '520_Feel_Good_satin_finish.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('67357ae4-342e-4673-b80f-1f1d2f000c0c', '080 Red Smile satin finish', 2, '080_Red_Smile_satin_finish.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('67357ae4-342e-4673-b80f-1f1d3f000c0c', 'Free Spirit', 2, 'Bobbi_Brown_Free_Spirit.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('67357ae4-342e-4673-b80f-1f1d4f000c0c', 'Force of Nature', 2, 'Bobbi_Brown_Force_of_Nature.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c310', 'A46', 2, 'a46.jpg', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c311', 'A47', 2, 'a47.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c312', 'A48', 2, 'a48.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c313', 'A49', 2, 'a49.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c314', 'A50', 2, 'a50.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c315', 'A51', 2, 'a51.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('ba2a17f3-5b4d-4a35-894e-e3ebbf27c316', 'A52', 2, 'a52.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('7d80bc43-7764-4c0f-9429-f4d3d675d63d', 'Merry Cherry', 1, 'Powder_Kiss_Velvet_Blur_Slim_Stick_Bizarre_Blizzard_Bash_Merry_Cherry.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('7d80bc43-7764-4c0f-9429-f4d3d675d64d', 'Peppery Pink', 1, 'Powder_Kiss_Velvet_Blur_Slim_Stick_Bizarre_Blizzard_Bash_Peppery_Pink.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('7d80bc43-7764-4c0f-9429-f4d3d675d65d', 'Cocoa Kisses', 1, 'Powder_Kiss_Velvet_Blur_Slim_Stick_Bizarre_Blizzard_Bash_Cocoa_Kisses.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110101'),
('7d80bc43-7764-4c0f-9429-f4d3d675d66d', 'Casual Affair', 1, '3CE-Blur_Water_Tint-Casual_Affair-Makeup-Moona-Store-NZ_720x.jpg', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d67d', 'Pink Guava', 1, '3CE-Blur_Water_Tint-Pink_Guava-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d68d', 'Spot Player', 1, '3CE-Blur_Water_Tint-Spot_Player-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d69d', 'Double Wind', 1, '3CE-Blur_Water_Tint-Double_Wind-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d70d', 'Warmth', 1, '3CE-Blur_Water_Tint-Warmth-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d71d', 'More Peach', 1, '3CE-Blur_Water_Tint-More_Peach-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d72d', 'Dear March', 1, '3CE-Blur_Water_Tint-Dear_March-Makeup-Moona-Store-NZ_720x.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110102'),
('7d80bc43-7764-4c0f-9429-f4d3d675d73d', '758 Lady Red', 1, 'Y0291000_C029100758_cs.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('7d80bc43-7764-4c0f-9429-f4d3d675d74d', '008 Dior 8', 1, 'Y0291000_C029100008_cs.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('7d80bc43-7764-4c0f-9429-f4d3d675d75d', '536 Lucky', 1, 'Y0291000_C029100536_cs.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('7d80bc43-7764-4c0f-9429-f4d3d675d76d', '745 Re(d)volution', 1, 'Y0291000_C029100745_cs.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('7d80bc43-7764-4c0f-9429-f4d3d675d77d', '841 Caro', 1, 'Y0291000_C029100841_cs.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110103'),
('7d80bc43-7764-4c0f-9429-f4d3d675d78d', 'Bold Honey', 1, 'bb_sku_EM4702_Bold_Honey.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d79d', 'Claret', 1, 'bb_sku_EM4702_Claret.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d80d', 'Paris Pink', 1, 'bb_sku_EM4702_Paris_Pink.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d81d', 'Showstopper', 1, 'bb_sku_EM4702_Showstopper.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d82d', 'Desert Sun', 1, 'bb_sku_EM4702_Desert_Sun.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d83d', 'Red Stiletto', 1, 'bb_sku_EM4702_Red_Stiletto.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d84d', 'Night Spell', 1, 'bb_sku_EM4702_Night_Spell.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110104'),
('7d80bc43-7764-4c0f-9429-f4d3d675d85d', 'HG05 - Pure orange', 1, 'hg05.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('7d80bc43-7764-4c0f-9429-f4d3d675d86d', 'HG06 - Grapefruit red', 1, 'hg06.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('7d80bc43-7764-4c0f-9429-f4d3d675d87d', 'HG07 - Peach brown', 1, 'hg07.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('7d80bc43-7764-4c0f-9429-f4d3d675d88d', 'HG08 - Brick red brown', 1, 'hg08.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105'),
('7d80bc43-7764-4c0f-9429-f4d3d675d89d', 'HG09 - Pink fig', 1, 'hg09.png', 0, '15333be6-0d95-4b7c-b0e9-ee00c5110105')
GO

--Nhập dữ liệu bảng Chi tiết Sản phẩm (ProductDetail)
INSERT INTO ProductDetail VALUES
('f548c39d-d212-45c3-b191-a2a80f8d9d1b', 20, 23, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f030c0c', '67357ae4-342e-4673-b80f-1f1d1f062c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d2b', 20, 23, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f030c0c', '67357ae4-342e-4673-b80f-1f1d1f061c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d3b', 20, 23, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f030c0c', '67357ae4-342e-4673-b80f-1f1d1f060c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d4b', 15, 18, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f020c0c', '67357ae4-342e-4673-b80f-1f1d1f050c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d5b', 15, 18, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f020c0c', '67357ae4-342e-4673-b80f-1f1d1f040c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d6b', 15, 20, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f010c0c', '67357ae4-342e-4673-b80f-1f1d1f000c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d7b', 15, 20, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f010c0c', '67357ae4-342e-4673-b80f-1f1d2f000c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d8b', 25, 33, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f000c0c', '67357ae4-342e-4673-b80f-1f1d3f000c0c'),
('f548c39d-d212-45c3-b191-a2a80f8d9d9b', 25, 33, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f000c0c', '67357ae4-342e-4673-b80f-1f1d4f000c0c'),
('5baaeb15-d505-4927-b7fd-eea39f61dc80', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c310'),
('5baaeb15-d505-4927-b7fd-eea39f61dc81', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c311'),
('5baaeb15-d505-4927-b7fd-eea39f61dc82', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c312'),
('5baaeb15-d505-4927-b7fd-eea39f61dc83', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c313'),
('5baaeb15-d505-4927-b7fd-eea39f61dc84', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c314'),
('5baaeb15-d505-4927-b7fd-eea39f61dc85', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c315'),
('5baaeb15-d505-4927-b7fd-eea39f61dc86', 10, 12, 1, '09/10/2023', 0, '', '67357ae4-342e-4673-b80f-1f1d1f070c0c', 'ba2a17f3-5b4d-4a35-894e-e3ebbf27c316'),
('79cebd85-1aea-4938-9f9a-9b15e9969e62', 25, 28, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4839', '7d80bc43-7764-4c0f-9429-f4d3d675d63d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e63', 25, 28, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4839', '7d80bc43-7764-4c0f-9429-f4d3d675d64d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e64', 25, 28, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4839', '7d80bc43-7764-4c0f-9429-f4d3d675d65d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e65', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d66d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e66', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d67d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e67', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d68d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e68', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d69d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e69', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d70d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e70', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d71d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e71', 22, 25, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4838', '7d80bc43-7764-4c0f-9429-f4d3d675d72d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e72', 33, 36, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '7d80bc43-7764-4c0f-9429-f4d3d675d73d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e73', 33, 36, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '7d80bc43-7764-4c0f-9429-f4d3d675d74d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e74', 33, 36, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '7d80bc43-7764-4c0f-9429-f4d3d675d75d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e75', 33, 36, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '7d80bc43-7764-4c0f-9429-f4d3d675d76d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e76', 33, 36, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4837', '7d80bc43-7764-4c0f-9429-f4d3d675d77d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e77', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d78d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e78', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d79d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e79', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d80d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e80', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d81d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e81', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d82d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e82', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d83d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e83', 26, 29, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4836', '7d80bc43-7764-4c0f-9429-f4d3d675d84d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e84', 6, 9, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '7d80bc43-7764-4c0f-9429-f4d3d675d85d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e85', 6, 9, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '7d80bc43-7764-4c0f-9429-f4d3d675d86d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e86', 6, 9, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '7d80bc43-7764-4c0f-9429-f4d3d675d87d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e87', 6, 9, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '7d80bc43-7764-4c0f-9429-f4d3d675d88d'),
('79cebd85-1aea-4938-9f9a-9b15e9969e88', 6, 9, 1, '09/10/2023', 0, '', '8958bbdc-bea0-4bb3-96c7-ebc6885f4835', '7d80bc43-7764-4c0f-9429-f4d3d675d89d')
GO

--Nhập dữ liệu bảng Hình ảnh Sản phẩm (ProductImage)
INSERT INTO ProductImage VALUES
('c823ef0b-8047-4713-b76a-66340c095221', 'MATTE_LIPSTICK1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d1b'),
('c823ef0b-8047-4713-b76a-66340c095222', 'MATTE_LIPSTICK2.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d1b'),
('c823ef0b-8047-4713-b76a-66340c095223', 'MATTE_LIPSTICK3.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d1b'),
('c823ef0b-8047-4713-b76a-66340c095224', 'MATTE_LIPSTICK4.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d2b'),
('c823ef0b-8047-4713-b76a-66340c095225', 'MATTE_LIPSTICK5.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d2b'),
('c823ef0b-8047-4713-b76a-66340c095226', 'MATTE_LIPSTICK3.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d2b'),
('c823ef0b-8047-4713-b76a-66340c095227', 'MATTE_LIPSTICK6.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d3b'),
('c823ef0b-8047-4713-b76a-66340c095228', 'MATTE_LIPSTICK7.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d3b'),
('c823ef0b-8047-4713-b76a-66340c095229', 'MATTE_LIPSTICK3.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d3b'),
('c823ef0b-8047-4713-b76a-66340c095240', 'Vanilla_Tea.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d4b'),
('c823ef0b-8047-4713-b76a-66340c095250', 'Jasmine_Tea.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d5b'),
('c823ef0b-8047-4713-b76a-66340c095260', 'Free_Spirit1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d8b'),
('c823ef0b-8047-4713-b76a-66340c095270', 'Free_Spirit2.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d8b'),
('c823ef0b-8047-4713-b76a-66340c095280', 'Crushed_Oil_Infused_Gloss.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d8b'),
('c823ef0b-8047-4713-b76a-66340c095200', 'Force_of_Nature1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d9b'),
('c823ef0b-8047-4713-b76a-66340c096000', 'Force_of_Nature2.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d9b'),
('c823ef0b-8047-4713-b76a-66340c097000', 'Crushed_Oil_Infused_Gloss.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d9b'),
('c823ef0b-8047-4713-b76a-66340c095900', '520_Feel_Good_satin_finish1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d6b'),
('c823ef0b-8047-4713-b76a-66340c091000', '520_Feel_Good_satin_finish2.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d6b'),
('c823ef0b-8047-4713-b76a-66340c092000', '520_Feel_Good_satin_finish3.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d6b'),
('c823ef0b-8047-4713-b76a-66340c093000', '080_Red_Smile_satin_finish2.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d7b'),
('c823ef0b-8047-4713-b76a-66340c094000', '080_Red_Smile_satin_finish3.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d7b'),
('c823ef0b-8047-4713-b76a-66340c095000', '080_Red_Smile_satin_finish1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d7b'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e437cf', 'a46.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc80'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e438cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc80'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e439cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc80'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e440cf', 'a47.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc81'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e441cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc81'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e442cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc81'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e443cf', 'a48.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc82'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e444cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc82'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e445cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc82'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e446cf', 'a49.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc83'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e447cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc83'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e448cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc83'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e449cf', 'a50.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc84'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e450cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc84'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e451cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc84'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e452cf', 'a51.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc85'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e453cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc85'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e454cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc85'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e455cf', 'a52.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc86'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e456cf', 'full-ver-9.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc86'),
('03e07e56-4b08-46a7-a2f7-7dc0d4e457cf', 'a9-1.png', 0, '5baaeb15-d505-4927-b7fd-eea39f61dc86'),
('c823ef0b-8047-4713-b76a-66340c095500', 'Romand_Milk_Tea_Velvet_Tint_Vanilla_Tea.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d4b'),
('c823ef0b-8047-4713-b76a-66340c095600', 'Romand_Milk_Tea_Velvet_Tint_Vanilla_Tea1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d4b'),
('c823ef0b-8047-4713-b76a-66340c095700', 'Romand_Milk_Tea_Velvet_Tint_Jasmine_Tea.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d5b'),
('c823ef0b-8047-4713-b76a-66340c095800', 'Romand_Milk_Tea_Velvet_Tint_Jasmine_Tea1.png', 0, 'f548c39d-d212-45c3-b191-a2a80f8d9d5b'),
('d1ce59c7-b512-4081-93cb-92e2ead8531f', 'mac_sku_STX528_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e62'),
('d1ce59c7-b512-4081-93cb-92e2ead8532f', 'mac_sku_STX528_1x1_1.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e62'),
('d1ce59c7-b512-4081-93cb-92e2ead8533f', 'mac_sku_STX528_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e62'),
('d1ce59c7-b512-4081-93cb-92e2ead8534f', 'mac_sku_STX521_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e63'),
('d1ce59c7-b512-4081-93cb-92e2ead8535f', 'mac_sku_STX521_1x1_1.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e63'),
('d1ce59c7-b512-4081-93cb-92e2ead8536f', 'mac_sku_STX528_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e63'),
('d1ce59c7-b512-4081-93cb-92e2ead8537f', 'mac_sku_STX527_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e64'),
('d1ce59c7-b512-4081-93cb-92e2ead8538f', 'mac_sku_STX527_1x1_1.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e64'),
('d1ce59c7-b512-4081-93cb-92e2ead8539f', 'mac_sku_STX528_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e64'),
('d1ce59c7-b512-4081-93cb-92e2ead8540f', '3CE-Blur_Water_Tint-Casual_Affair-Makeup-Moona-Store-NZ_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e65'),
('d1ce59c7-b512-4081-93cb-92e2ead8541f', '3CE-Blur_Water_Tint-Casual_Affair-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e65'),
('d1ce59c7-b512-4081-93cb-92e2ead8542f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e65'),
('d1ce59c7-b512-4081-93cb-92e2ead8543f', '3CE-Blur_Water_Tint-Pink_Guava-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e66'),
('d1ce59c7-b512-4081-93cb-92e2ead8544f', '3CE-Blur_Water_Tint-Pink_Guava-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e66'),
('d1ce59c7-b512-4081-93cb-92e2ead8545f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e66'),
('d1ce59c7-b512-4081-93cb-92e2ead8546f', '3CE-Blur_Water_Tint-Spot_Player-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e67'),
('d1ce59c7-b512-4081-93cb-92e2ead8547f', '3CE-Blur_Water_Tint-Spot_Player-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e67'),
('d1ce59c7-b512-4081-93cb-92e2ead8548f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e67'),
('d1ce59c7-b512-4081-93cb-92e2ead8549f', '3CE-Blur_Water_Tint-Double_Wind-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e68'),
('d1ce59c7-b512-4081-93cb-92e2ead8550f', '3CE-Blur_Water_Tint-Double_Wind-Makeup-Moona-Store-NZ-1_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e68'),
('d1ce59c7-b512-4081-93cb-92e2ead8551f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e68'),
('d1ce59c7-b512-4081-93cb-92e2ead8552f', '3CE-Blur_Water_Tint-Warmth-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e69'),
('d1ce59c7-b512-4081-93cb-92e2ead8553f', '3CE-Blur_Water_Tint-Warmth-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e69'),
('d1ce59c7-b512-4081-93cb-92e2ead8554f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e69'),
('d1ce59c7-b512-4081-93cb-92e2ead8555f', '3CE-Blur_Water_Tint-More_Peach-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e70'),
('d1ce59c7-b512-4081-93cb-92e2ead8556f', '3CE-Blur_Water_Tint-More_Peach-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e70'),
('d1ce59c7-b512-4081-93cb-92e2ead8557f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e70'),
('d1ce59c7-b512-4081-93cb-92e2ead8558f', '3CE-Blur_Water_Tint-Dear_March-Makeup-Moona-Store-NZ_720x.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e71'),
('d1ce59c7-b512-4081-93cb-92e2ead8559f', '3CE-Blur_Water_Tint-Dear_March-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e71'),
('d1ce59c7-b512-4081-93cb-92e2ead8560f', '3CE-Blur_Water_Tint-Makeup-Moona-Store-NZ-1_720x.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e71'),
('d1ce59c7-b512-4081-93cb-92e2ead8561f', 'Y0291000_C029100758_E02_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e72'),
('d1ce59c7-b512-4081-93cb-92e2ead8562f', 'Y0291000_C029100758_E01_ZHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e72'),
('d1ce59c7-b512-4081-93cb-92e2ead8563f', 'Y0291000_C029100008_E02_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e73'),
('d1ce59c7-b512-4081-93cb-92e2ead8564f', 'Y0291000_C029100008_E03_GHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e73'),
('d1ce59c7-b512-4081-93cb-92e2ead8565f', 'Y0291000_C029100008_E01_ZHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e73'),
('d1ce59c7-b512-4081-93cb-92e2ead8566f', 'Y0291000_C029100536_E02_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e74'),
('d1ce59c7-b512-4081-93cb-92e2ead8567f', 'Y0291000_C029100536_E03_GHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e74'),
('d1ce59c7-b512-4081-93cb-92e2ead8568f', 'Y0291000_C029100536_E01_ZHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e74'),
('d1ce59c7-b512-4081-93cb-92e2ead8569f', 'Y0291000_C029100745_E02_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e75'),
('d1ce59c7-b512-4081-93cb-92e2ead8570f', 'Y0291000_C029100745_E03_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e75'),
('d1ce59c7-b512-4081-93cb-92e2ead8571f', 'Y0291000_C029100745_E01_ZHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e75'),
('d1ce59c7-b512-4081-93cb-92e2ead8572f', 'Y0291000_C029100841_E02_GHC.jpg', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e76'),
('d1ce59c7-b512-4081-93cb-92e2ead8573f', 'Y0291000_C029100841_E03_GHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e76'),
('d1ce59c7-b512-4081-93cb-92e2ead8574f', 'Y0291000_C029100841_E01_ZHC.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e76'),
('d1ce59c7-b512-4081-93cb-92e2ead8575f', 'bb_sku_EM4702_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e77'),
('d1ce59c7-b512-4081-93cb-92e2ead8576f', 'bb_sku_EM4702_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e77'),
('d1ce59c7-b512-4081-93cb-92e2ead8577f', 'bb_sku_EM4702_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e77'),
('d1ce59c7-b512-4081-93cb-92e2ead8578f', 'bb_sku_EWNC04_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e78'),
('d1ce59c7-b512-4081-93cb-92e2ead8579f', 'bb_sku_EWNC04_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e78'),
('d1ce59c7-b512-4081-93cb-92e2ead8580f', 'bb_sku_EM4707_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e79'),
('d1ce59c7-b512-4081-93cb-92e2ead8581f', 'bb_sku_EM4707_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e79'),
('d1ce59c7-b512-4081-93cb-92e2ead8582f', 'bb_sku_EM4707_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e79'),
('d1ce59c7-b512-4081-93cb-92e2ead8583f', 'bb_sku_EM4712_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e80'),
('d1ce59c7-b512-4081-93cb-92e2ead8584f', 'bb_sku_EM4712_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e80'),
('d1ce59c7-b512-4081-93cb-92e2ead8585f', 'bb_sku_EM4712_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e80'),
('d1ce59c7-b512-4081-93cb-92e2ead8586f', 'bb_sku_EM4713_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e81'),
('d1ce59c7-b512-4081-93cb-92e2ead8587f', 'bb_sku_EM4713_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e81'),
('d1ce59c7-b512-4081-93cb-92e2ead8588f', 'bb_sku_EM4713_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e81'),
('d1ce59c7-b512-4081-93cb-92e2ead8589f', 'bb_sku_EM4708_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e82'),
('d1ce59c7-b512-4081-93cb-92e2ead8590f', 'bb_sku_EM4708_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e82'),
('d1ce59c7-b512-4081-93cb-92e2ead8591f', 'bb_sku_EM4708_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e82'),
('d1ce59c7-b512-4081-93cb-92e2ead8592f', 'bb_sku_EM4714_1x1_0.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e83'),
('d1ce59c7-b512-4081-93cb-92e2ead8593f', 'bb_sku_EM4714_1x1_1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e83'),
('d1ce59c7-b512-4081-93cb-92e2ead8594f', 'bb_sku_EM4714_1x1_2.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e83'),
('d1ce59c7-b512-4081-93cb-92e2ead1100f', 'hg05.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e84'),
('d1ce59c7-b512-4081-93cb-92e2ead1200f', 'hg2-1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e84'),
('d1ce59c7-b512-4081-93cb-92e2ead1300f', 'hnh.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e84'),
('d1ce59c7-b512-4081-93cb-92e2ead1400f', 'hg06.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e85'),
('d1ce59c7-b512-4081-93cb-92e2ead1500f', 'hg2-1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e85'),
('d1ce59c7-b512-4081-93cb-92e2ead1600f', 'hnh.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e85'),
('d1ce59c7-b512-4081-93cb-92e2ead1700f', 'hg07.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e86'),
('d1ce59c7-b512-4081-93cb-92e2ead1800f', 'hg2-1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e86'),
('d1ce59c7-b512-4081-93cb-92e2ead1900f', 'hnh.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e86'),
('d1ce59c7-b512-4081-93cb-92e2ead2000f', 'hg08.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e87'),
('d1ce59c7-b512-4081-93cb-92e2ead2100f', 'hg2-1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e87'),
('d1ce59c7-b512-4081-93cb-92e2ead2200f', 'hnh.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e87'),
('d1ce59c7-b512-4081-93cb-92e2ead2300f', 'hg09.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e88'),
('d1ce59c7-b512-4081-93cb-92e2ead2400f', 'hg2-1.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e88'),
('d1ce59c7-b512-4081-93cb-92e2ead2500f', 'hnh.png', 0, '79cebd85-1aea-4938-9f9a-9b15e9969e88')
GO

--Nhập dữ liệu bảng Người dùng (Customer)
INSERT INTO Customer VALUES
('67357ae4-342e-4673-b80f-1f1d1f068c5c', 'Luc Minh Quan', 'quanlm', '123456', 0, '0987654323', 'quanlm@gmail.com', '01/01/2003', '09/10/2023', 'Hanoi', 0),
('67357ae4-342e-4673-b80f-1f1d1f068c6c', 'Luc Van Quan', 'quanlv', '123456', 0, '0987654324', 'quanlv@gmail.com', '01/01/2003', '09/10/2023', 'Hanoi', 0)
GO

--Nhập dữ liệu bảng Danh sách Yêu Thích (WishList)
INSERT INTO WishList VALUES
('6d95a8ae-1e83-4c7d-a813-a5a3640bc711', '67357ae4-342e-4673-b80f-1f1d1f030c0c', '67357ae4-342e-4673-b80f-1f1d1f068c5c'),
('6d95a8ae-1e83-4c7d-a813-a5a3640bc712', '67357ae4-342e-4673-b80f-1f1d1f070c0c', '67357ae4-342e-4673-b80f-1f1d1f068c5c'),
('6d95a8ae-1e83-4c7d-a813-a5a3640bc713', '67357ae4-342e-4673-b80f-1f1d1f020c0c', '67357ae4-342e-4673-b80f-1f1d1f068c6c'),
('6d95a8ae-1e83-4c7d-a813-a5a3640bc714', '67357ae4-342e-4673-b80f-1f1d1f010c0c', '67357ae4-342e-4673-b80f-1f1d1f068c6c'),
('6d95a8ae-1e83-4c7d-a813-a5a3640bc715', '67357ae4-342e-4673-b80f-1f1d1f000c0c', '67357ae4-342e-4673-b80f-1f1d1f068c6c')
GO

--Nhập dữ liệu bảng Giỏ hàng (Cart)
INSERT INTO Cart VALUES
('67357ae4-342e-4673-b80f-1f1d1f068c5c', 3, 71, 0, '67357ae4-342e-4673-b80f-1f1d1f068c5c'),
('67357ae4-342e-4673-b80f-1f1d1f068c6c', 1, 23, 0, '67357ae4-342e-4673-b80f-1f1d1f068c6c')
GO

--Nhập dữ liệu bảng Chi Tiết Giỏ hàng (CartDetail)
INSERT INTO CartDetail VALUES
('6109da61-a526-4776-a82c-3dec24717b1a', 1, 18, '67357ae4-342e-4673-b80f-1f1d1f068c5c', 'f548c39d-d212-45c3-b191-a2a80f8d9d4b'),
('6109da61-a526-4776-a82c-3dec24717b2a', 1, 20, '67357ae4-342e-4673-b80f-1f1d1f068c5c', 'f548c39d-d212-45c3-b191-a2a80f8d9d6b'),
('6109da61-a526-4776-a82c-3dec24717b3a', 1, 33, '67357ae4-342e-4673-b80f-1f1d1f068c5c', 'f548c39d-d212-45c3-b191-a2a80f8d9d9b'),
('6109da61-a526-4776-a82c-3dec24717b4a', 1, 23, '67357ae4-342e-4673-b80f-1f1d1f068c6c', 'f548c39d-d212-45c3-b191-a2a80f8d9d1b')
GO

--Nhập dữ liệu bảng Chức vụ (Role)
INSERT INTO Role VALUES
('67357ae4-342e-4673-b80f-1f1d1f068c1c', 'Staff', 0),
('67357ae4-342e-4673-b80f-1f1d1f068c2c', 'Manage', 0)
GO

--Nhập dữ liệu bảng  (Employee)
INSERT INTO Employee VALUES
('9c7cf1ed-8f0a-44c3-8dc1-a652a37c0279', 'Hoang Thanh Tung', 'tunght', '123456', 0, '0987654321', 'tunght@gmail.com', 'avatar1.png', '01/01/2003', '09/10/2023', 'Hanoi', 0, '67357ae4-342e-4673-b80f-1f1d1f068c1c'),
('9c7cf1ed-8f0a-44c3-8dc1-a652a37c0278', 'Hoang Van Tung', 'tunghv', '123456', 0, '0987654322', 'tunghv@gmail.com', 'avatar2.png', '01/01/2003', '09/10/2023', 'Hanoi', 0, '67357ae4-342e-4673-b80f-1f1d1f068c2c')
GO

--Nhập dữ liệu bảng Trạng thái hóa đơn (BillStatus)
INSERT INTO BillStatus VALUES
('159b8bc3-5489-47c0-a115-b94a0cf6286f', 'Confirmed', 0),
('259b8bc3-5489-47c0-a115-b94a0cf6286f', 'Unconfirmed', 0)
GO

--Nhập dữ liệu bảng Phương thức thanh toán (Payment)
INSERT INTO Payment VALUES
('1f7fbcf3-3007-4180-a5fe-84d2bcdf171b', 'Bank transfer', 0),
('2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', 'Ship (COD)', 0)
GO

--Nhập dữ liệu bảng Hóa đơn (Bill)
INSERT INTO Bill VALUES
('126195bb-2b4f-4a91-ab4f-0acf00306616', 'Luc Minh Quan', 45, '0987654323', 'Hanoi', '10/09/2023', '159b8bc3-5489-47c0-a115-b94a0cf6286f', '2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', '9c7cf1ed-8f0a-44c3-8dc1-a652a37c0279', '67357ae4-342e-4673-b80f-1f1d1f068c5c'),
('226195bb-2b4f-4a91-ab4f-0acf00306616', 'Luc Van Quan', 50, '0987654323', 'Hanoi', '10/09/2023', '159b8bc3-5489-47c0-a115-b94a0cf6286f', '2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', '9c7cf1ed-8f0a-44c3-8dc1-a652a37c0278', '67357ae4-342e-4673-b80f-1f1d1f068c6c'),
('326195bb-2b4f-4a91-ab4f-0acf00306616', 'Luc Minh Quan', 21, '0987654323', 'Hanoi', '10/09/2023', '159b8bc3-5489-47c0-a115-b94a0cf6286f', '2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', '9c7cf1ed-8f0a-44c3-8dc1-a652a37c0279', '67357ae4-342e-4673-b80f-1f1d1f068c5c'),
('426195bb-2b4f-4a91-ab4f-0acf00306616', 'Luc Van Quan', 33, '0987654323', 'Hanoi', '10/09/2023', '159b8bc3-5489-47c0-a115-b94a0cf6286f', '2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', '9c7cf1ed-8f0a-44c3-8dc1-a652a37c0278', '67357ae4-342e-4673-b80f-1f1d1f068c6c'),
('526195bb-2b4f-4a91-ab4f-0acf00306616', 'Luc Van Quan', 52, '0987654323', 'Hanoi', '10/09/2023', '159b8bc3-5489-47c0-a115-b94a0cf6286f', '2f7fbcf3-3007-4180-a5fe-84d2bcdf171b', '9c7cf1ed-8f0a-44c3-8dc1-a652a37c0278', '67357ae4-342e-4673-b80f-1f1d1f068c6c')
GO

--Nhập dữ liệu bảng Chi tiết Hóa đơn (BillDetail)
INSERT INTO BillDetail VALUES
('ada72d63-1447-4d82-bb84-d6b0103c7230', 1, 20, '126195bb-2b4f-4a91-ab4f-0acf00306616', 'f548c39d-d212-45c3-b191-a2a80f8d9d6b'),
('ada72d63-1447-4d82-bb84-d6b0103c7231', 1, 25, '126195bb-2b4f-4a91-ab4f-0acf00306616', '79cebd85-1aea-4938-9f9a-9b15e9969e68'),
('ada72d63-1447-4d82-bb84-d6b0103c7232', 1, 20, '226195bb-2b4f-4a91-ab4f-0acf00306616', 'f548c39d-d212-45c3-b191-a2a80f8d9d7b'),
('ada72d63-1447-4d82-bb84-d6b0103c7233', 1, 18, '226195bb-2b4f-4a91-ab4f-0acf00306616', 'f548c39d-d212-45c3-b191-a2a80f8d9d5b'),
('ada72d63-1447-4d82-bb84-d6b0103c7234', 1, 12, '226195bb-2b4f-4a91-ab4f-0acf00306616', '5baaeb15-d505-4927-b7fd-eea39f61dc80'),
('ada72d63-1447-4d82-bb84-d6b0103c7235', 1, 12, '326195bb-2b4f-4a91-ab4f-0acf00306616', '5baaeb15-d505-4927-b7fd-eea39f61dc82'),
('ada72d63-1447-4d82-bb84-d6b0103c7236', 1, 9, '326195bb-2b4f-4a91-ab4f-0acf00306616', '79cebd85-1aea-4938-9f9a-9b15e9969e85'),
('ada72d63-1447-4d82-bb84-d6b0103c7237', 1, 36, '426195bb-2b4f-4a91-ab4f-0acf00306616', '79cebd85-1aea-4938-9f9a-9b15e9969e72'),
('ada72d63-1447-4d82-bb84-d6b0103c7238', 1, 25, '526195bb-2b4f-4a91-ab4f-0acf00306616', '79cebd85-1aea-4938-9f9a-9b15e9969e69'),
('ada72d63-1447-4d82-bb84-d6b0103c7239', 1, 29, '526195bb-2b4f-4a91-ab4f-0acf00306616', '79cebd85-1aea-4938-9f9a-9b15e9969e80')
GO

--Nhập dữ liệu bảng Voucher (Voucher)
INSERT INTO Voucher VALUES
('31c17634-be31-43c7-ac64-46f30fbe3b11', 'MEOWSHOP', 3, '10/09/2023', '11/20/2023', '10/09/2023', 0),
('31c17634-be31-43c7-ac64-46f30fbe3b12', 'MEOW', 2,  '10/09/2023', '11/20/2023', '10/09/2023', 0)
GO

--Nhập dữ liệu bảng Chi tiết UsedVoucher (UsedVoucher)
INSERT INTO UsedVoucher VALUES
('215d4e1a-b541-4008-bbef-9b3b5a84f3e1', 36, '426195bb-2b4f-4a91-ab4f-0acf00306616', '31c17634-be31-43c7-ac64-46f30fbe3b11'),
('215d4e1a-b541-4008-bbef-9b3b5a84f3e2', 54, '526195bb-2b4f-4a91-ab4f-0acf00306616', '31c17634-be31-43c7-ac64-46f30fbe3b12')
GO