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