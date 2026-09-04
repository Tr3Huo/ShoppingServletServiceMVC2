CREATE TABLE Category(
    [cate_id] [int] IDENTITY(1,1) NOT NULL,
    [cate_name] [nvarchar] (255) NOT NULL,
    [icons] [nvarchar] (255) NULL,
PRIMARY KEY CLUSTERED 
(
    [cate_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) NULL,
    password VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    fullname NVARCHAR(255) NULL,
    roleid INT NULL,
    phone VARCHAR(20) NULL
);
GO

INSERT INTO users (username, password, email, fullname, roleid, phone)
VALUES ('admin', '123', 'admin@gmail.com', N'Quản Trị Viên', 1, '0987654321');
GO