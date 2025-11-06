USE [ClassDemo]
GO
/****** Object:  Table [dbo].[Author_Book]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author_Book](
	[Author_BookID] [int] NOT NULL,
	[BookId] [int] NOT NULL,
	[AuthorId] [int] NOT NULL,
	[isMain] [bit] NOT NULL,
 CONSTRAINT [PK_Author_Book] PRIMARY KEY CLUSTERED 
(
	[Author_BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Bio] [nvarchar](max) NULL,
	[BirthDate] [date] NULL,
	[Nationality] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
	[Genre] [nvarchar](100) NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Stock] [int] NULL,
	[PublishDate] [date] NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
	[Country] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderBooks]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderBooks](
	[OrderBookID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderBookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 11/6/2025 8:30:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[PaymentDate] [datetime] NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[TransactionReference] [nvarchar](100) NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (2, 2, 1, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (3, 3, 2, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (4, 4, 3, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (5, 5, 4, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (6, 6, 5, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (7, 7, 5, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (8, 7, 3, 0)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (9, 8, 4, 1)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (10, 8, 1, 0)
GO
INSERT [dbo].[Author_Book] ([Author_BookID], [BookId], [AuthorId], [isMain]) VALUES (11, 8, 2, 0)
GO
SET IDENTITY_INSERT [dbo].[Authors] ON 
GO
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName], [Bio], [BirthDate], [Nationality], [CreatedAt]) VALUES (1, N'George', N'Orwell', N'English novelist, essayist, journalist, and critic.', CAST(N'1903-06-25' AS Date), N'British', CAST(N'2025-10-21T10:16:07.610' AS DateTime))
GO
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName], [Bio], [BirthDate], [Nationality], [CreatedAt]) VALUES (2, N'J.K.', N'Rowling', N'Author of the Harry Potter fantasy series.', CAST(N'1965-07-31' AS Date), N'British', CAST(N'2025-10-21T10:16:07.610' AS DateTime))
GO
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName], [Bio], [BirthDate], [Nationality], [CreatedAt]) VALUES (3, N'Stephen', N'King', N'American author of horror, supernatural fiction, suspense, and fantasy.', CAST(N'1947-09-21' AS Date), N'American', CAST(N'2025-10-21T10:16:07.610' AS DateTime))
GO
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName], [Bio], [BirthDate], [Nationality], [CreatedAt]) VALUES (4, N'Agatha', N'Christie', N'English writer known for her detective novels.', CAST(N'1890-09-15' AS Date), N'British', CAST(N'2025-10-21T10:16:07.610' AS DateTime))
GO
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName], [Bio], [BirthDate], [Nationality], [CreatedAt]) VALUES (5, N'Dan', N'Brown', N'American author best known for thrillers.', CAST(N'1964-06-22' AS Date), N'American', CAST(N'2025-10-21T10:16:07.610' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Authors] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (1, N'1984', N'9780451524935', N'Dystopian', CAST(12.99 AS Decimal(10, 2)), 50, CAST(N'1949-06-08' AS Date), N'A dystopian social science fiction novel and cautionary tale.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (2, N'Animal Farm', N'9780451526342', N'Political Satire', CAST(9.99 AS Decimal(10, 2)), 40, CAST(N'1945-08-17' AS Date), N'An allegorical novella reflecting events leading up to the Russian Revolution.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (3, N'Harry Potter and the Sorcerer''s Stone', N'9780439554930', N'Fantasy', CAST(14.99 AS Decimal(10, 2)), 100, CAST(N'1997-06-26' AS Date), N'The first novel in the Harry Potter series.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (4, N'The Shining', N'9780385121675', N'Horror', CAST(15.99 AS Decimal(10, 2)), 60, CAST(N'1977-01-28' AS Date), N'A psychological horror novel.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (5, N'Murder on the Orient Express', N'9780007119318', N'Mystery', CAST(11.99 AS Decimal(10, 2)), 30, CAST(N'1934-01-01' AS Date), N'Detective Hercule Poirot investigates a murder on a train.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (6, N'The Da Vinci Code', N'9780307474278', N'Thriller', CAST(13.99 AS Decimal(10, 2)), 70, CAST(N'2003-03-18' AS Date), N'A symbologist and cryptologist uncover secrets of the Holy Grail.', CAST(N'2025-10-21T10:16:07.727' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (7, N'The Coded Conspiracy', N'9780312345678', N'Thriller / Mystery', CAST(16.99 AS Decimal(10, 2)), 40, CAST(N'2020-05-15' AS Date), N'A fast-paced thriller combining cryptic codes and psychological suspense.', CAST(N'2025-10-21T10:21:27.870' AS DateTime))
GO
INSERT [dbo].[Books] ([BookID], [Title], [ISBN], [Genre], [Price], [Stock], [PublishDate], [Description], [CreatedAt]) VALUES (8, N'Tales of the Unknown', N'9780987654321', N'Fantasy / Mystery', CAST(18.50 AS Decimal(10, 2)), 55, CAST(N'2021-11-01' AS Date), N'An anthology of mysterious and magical short stories written by three legendary authors.', CAST(N'2025-10-21T10:21:27.870' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (1, N'John', N'Smith', N'john.smith@example.com', N'+1-555-1010', N'123 Elm St', N'New York', N'USA', CAST(N'2025-10-21T10:16:07.977' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (2, N'Emily', N'Brown', N'emily.brown@example.com', N'+44-7700-123456', N'45 Queen St', N'London', N'UK', CAST(N'2025-10-21T10:16:07.977' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (3, N'Ali', N'Hassan', N'ali.hassan@example.com', N'+961-3-456789', N'Hamra Street', N'Beirut', N'Lebanon', CAST(N'2025-10-21T10:16:07.977' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (4, N'Sophie', N'Dubois', N'sophie.dubois@example.com', N'+33-6-55555555', N'12 Rue de Paris', N'Paris', N'France', CAST(N'2025-10-21T10:16:07.977' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (5, N'Carlos', N'Mendez', N'carlos.mendez@example.com', N'+34-600-999999', N'Gran Via 10', N'Madrid', N'Spain', CAST(N'2025-10-21T10:16:07.977' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (6, N'Lara', N'Miller', N'lara.miller@example.com', N'+1-555-2222', N'56 Broadway Ave', N'New York', N'USA', CAST(N'2025-11-04T09:51:18.710' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (7, N'Omar', N'Khaled', N'omar.khaled@example.com', N'+971-50-7777777', N'Sheikh Zayed Rd', N'Dubai', N'UAE', CAST(N'2025-11-04T09:51:18.710' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (8, N'Maria', N'Rossi', N'maria.rossi@example.com', N'+39-333-1111111', N'Via Roma 25', N'Rome', N'Italy', CAST(N'2025-11-04T09:51:18.710' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (9, N'Kenji', N'Tanaka', N'kenji.tanaka@example.com', N'+81-90-12345678', N'Shibuya Crossing', N'Tokyo', N'Japan', CAST(N'2025-11-04T09:51:18.710' AS DateTime))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Email], [Phone], [Address], [City], [Country], [CreatedAt]) VALUES (10, N'Emma', N'Johnson', N'emma.johnson@example.com', N'+1-555-3333', N'88 Pine St', N'San Francisco', N'USA', CAST(N'2025-11-04T09:51:18.710' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderBooks] ON 
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (1, 1, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (2, 1, 2, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (3, 2, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (4, 3, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (5, 4, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (6, 4, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (7, 5, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (8, 6, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (9, 6, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (10, 6, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (11, 6, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (12, 6, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (13, 6, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (14, 7, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (15, 7, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (16, 7, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (17, 7, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (18, 7, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (19, 8, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (20, 8, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (21, 8, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (22, 8, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (23, 8, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (24, 8, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (25, 8, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (26, 9, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (27, 9, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (28, 9, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (29, 9, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (30, 9, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (31, 10, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (32, 10, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (33, 10, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (34, 10, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (35, 10, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (36, 10, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (37, 10, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (38, 10, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (39, 11, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (40, 11, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (41, 11, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (42, 11, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (43, 11, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (44, 11, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (45, 12, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (46, 12, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (47, 12, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (48, 12, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (49, 12, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (50, 12, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (51, 12, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (52, 13, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (53, 13, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (54, 13, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (55, 13, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (56, 13, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (57, 14, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (58, 14, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (59, 14, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (60, 14, 8, 2, CAST(18.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (61, 14, 1, 2, CAST(12.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (62, 15, 2, 2, CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (63, 15, 3, 2, CAST(14.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (64, 15, 4, 2, CAST(15.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (65, 15, 5, 2, CAST(11.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (66, 15, 6, 2, CAST(13.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderBooks] ([OrderBookID], [OrderID], [BookID], [Quantity], [UnitPrice]) VALUES (67, 15, 7, 2, CAST(16.99 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[OrderBooks] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1, 1, CAST(N'2025-10-21T10:16:08.087' AS DateTime), CAST(27.98 AS Decimal(10, 2)), N'Completed')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2, 2, CAST(N'2025-10-21T10:16:08.087' AS DateTime), CAST(14.99 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3, 3, CAST(N'2025-10-21T10:16:08.087' AS DateTime), CAST(15.99 AS Decimal(10, 2)), N'Completed')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4, 4, CAST(N'2025-10-21T10:16:08.087' AS DateTime), CAST(25.98 AS Decimal(10, 2)), N'Completed')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5, 5, CAST(N'2025-10-21T10:16:08.087' AS DateTime), CAST(13.99 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (6, 6, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(79.94 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (7, 7, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(72.46 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (8, 8, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(103.44 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (9, 9, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(71.95 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (10, 10, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(115.43 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (11, 1, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(79.94 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (12, 2, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(105.44 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (13, 3, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(74.46 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (14, 4, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(73.46 AS Decimal(10, 2)), N'Pending')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (15, 5, CAST(N'2025-11-04T09:51:18.827' AS DateTime), CAST(83.94 AS Decimal(10, 2)), N'Pending')
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (1, 1, CAST(N'2025-10-21T10:16:08.307' AS DateTime), CAST(27.98 AS Decimal(10, 2)), N'Credit Card', N'TXN1001', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (2, 2, CAST(N'2025-10-21T10:16:08.307' AS DateTime), CAST(14.99 AS Decimal(10, 2)), N'PayPal', N'TXN1002', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (3, 3, CAST(N'2025-10-21T10:16:08.307' AS DateTime), CAST(15.99 AS Decimal(10, 2)), N'Credit Card', N'TXN1003', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (4, 4, CAST(N'2025-10-21T10:16:08.307' AS DateTime), CAST(25.98 AS Decimal(10, 2)), N'Bank Transfer', N'TXN1004', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (5, 5, CAST(N'2025-10-21T10:16:08.307' AS DateTime), CAST(13.99 AS Decimal(10, 2)), N'Cash', N'TXN1005', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (6, 6, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(79.94 AS Decimal(10, 2)), N'PayPal', N'TXN2006', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (7, 7, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(72.46 AS Decimal(10, 2)), N'Credit Card', N'TXN2007', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (8, 8, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(103.44 AS Decimal(10, 2)), N'Bank Transfer', N'TXN2008', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (9, 9, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(71.95 AS Decimal(10, 2)), N'PayPal', N'TXN2009', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (10, 10, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(115.43 AS Decimal(10, 2)), N'Credit Card', N'TXN2010', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (11, 11, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(79.94 AS Decimal(10, 2)), N'Bank Transfer', N'TXN2011', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (12, 12, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(105.44 AS Decimal(10, 2)), N'PayPal', N'TXN2012', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (13, 13, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(74.46 AS Decimal(10, 2)), N'Credit Card', N'TXN2013', N'Pending')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (14, 14, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(73.46 AS Decimal(10, 2)), N'Bank Transfer', N'TXN2014', N'Completed')
GO
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [PaymentDate], [Amount], [PaymentMethod], [TransactionReference], [Status]) VALUES (15, 15, CAST(N'2025-11-04T09:51:19.227' AS DateTime), CAST(83.94 AS Decimal(10, 2)), N'PayPal', N'TXN2015', N'Pending')
GO
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Books__447D36EA726EB649]    Script Date: 11/6/2025 8:30:15 AM ******/
ALTER TABLE [dbo].[Books] ADD UNIQUE NONCLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__A9D105347DADE670]    Script Date: 11/6/2025 8:30:15 AM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Authors] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT ('Completed') FOR [Status]
GO
ALTER TABLE [dbo].[Author_Book]  WITH CHECK ADD  CONSTRAINT [FK_Author_Book_Authors] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([AuthorID])
GO
ALTER TABLE [dbo].[Author_Book] CHECK CONSTRAINT [FK_Author_Book_Authors]
GO
ALTER TABLE [dbo].[Author_Book]  WITH CHECK ADD  CONSTRAINT [FK_Author_Book_Books] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([BookID])
GO
ALTER TABLE [dbo].[Author_Book] CHECK CONSTRAINT [FK_Author_Book_Books]
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD  CONSTRAINT [FK_OrderBooks_Books] FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([BookID])
GO
ALTER TABLE [dbo].[OrderBooks] CHECK CONSTRAINT [FK_OrderBooks_Books]
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD  CONSTRAINT [FK_OrderBooks_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderBooks] CHECK CONSTRAINT [FK_OrderBooks_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
