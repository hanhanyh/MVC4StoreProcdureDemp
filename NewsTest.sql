USE [master]
GO
/****** Object:  Database [NewsTest1]    Script Date: 2018/4/12 10:08:50 ******/
CREATE DATABASE [NewsTest1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NewsTest1', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\NewsTest1.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NewsTest1_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\NewsTest1_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NewsTest1] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NewsTest1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NewsTest1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NewsTest1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NewsTest1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NewsTest1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NewsTest1] SET ARITHABORT OFF 
GO
ALTER DATABASE [NewsTest1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NewsTest1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NewsTest1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NewsTest1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NewsTest1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NewsTest1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NewsTest1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NewsTest1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NewsTest1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NewsTest1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NewsTest1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NewsTest1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NewsTest1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NewsTest1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NewsTest1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NewsTest1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NewsTest1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NewsTest1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NewsTest1] SET  MULTI_USER 
GO
ALTER DATABASE [NewsTest1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NewsTest1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NewsTest1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NewsTest1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NewsTest1] SET DELAYED_DURABILITY = DISABLED 
GO
USE [NewsTest1]
GO
/****** Object:  Table [dbo].[NewsInfo]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](50) NOT NULL,
	[auter] [nvarchar](50) NOT NULL,
	[time] [datetime] NOT NULL,
	[content] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[NewsInfo] ON 

INSERT [dbo].[NewsInfo] ([ID], [Name], [Class], [auter], [time], [content]) VALUES (1, N'新闻1', N'分类1', N'作者1', CAST(N'2018-04-11 11:13:13.000' AS DateTime), N'内容1')
INSERT [dbo].[NewsInfo] ([ID], [Name], [Class], [auter], [time], [content]) VALUES (2, N'新闻2', N'分类2', N'作者2', CAST(N'2018-04-11 11:13:40.000' AS DateTime), N'neiorng 2')
INSERT [dbo].[NewsInfo] ([ID], [Name], [Class], [auter], [time], [content]) VALUES (3, N'新闻3', N'分类23', N'作者3', CAST(N'2018-04-11 11:50:17.000' AS DateTime), N'内容333')
INSERT [dbo].[NewsInfo] ([ID], [Name], [Class], [auter], [time], [content]) VALUES (4, N'新闻4', N'分类5', N'作者6', CAST(N'2018-04-11 11:51:09.000' AS DateTime), N'内容55')
SET IDENTITY_INSERT [dbo].[NewsInfo] OFF
/****** Object:  StoredProcedure [dbo].[AddnewS]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AddnewS]
	@Name nvarchar(50),
	@Class nvarchar(50),
	@auter nvarchar(50),
	@time datetime ,
	@content nvarchar(50),
	@ID int output
AS 
BEGIN
 insert into NewsInfo Values(@Name,@Class,@auter,@time,@content)
 select @ID=MAX(@ID) from NewsInfo
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteNews]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteNews]
	@ID int
AS
BEGIN
	delete NewsInfo where ID=@ID;
	select * from NewsInfo
end
GO
/****** Object:  StoredProcedure [dbo].[GetDataByIndex]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetDataByIndex]
     @pageindex int,
     @pagecount int output
AS
BEGIN
     declare @sql nvarchar(1000)
     declare @Pagec int
     set @sql='select top 5 * from NewsInfo where ID not in (select top '+CAST(@pageindex*5 as nvarchar(10))+' ID from NewsInfo)'
     select @pagecount=COUNT(*) from NewsInfo
     select @pagec = COUNT(*) from NewsInfo 
     set @pagecount = (@pagec+9)/5
     exec (@sql)
END

GO
/****** Object:  StoredProcedure [dbo].[SelectNews]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectNews]
AS
begin
	select * from NewsInfo
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateNews]    Script Date: 2018/4/12 10:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateNews]
	@Name nvarchar(50),
	@Class nvarchar(50),
	@auter nvarchar(50),
	@time datetime ,
	@content nvarchar(50),
	@id int
AS
BEGIN
	update NewsInfo set Name=@Name,Class=@Class,auter=@auter,time=@time,content=@content
	where ID=@id
end
GO
USE [master]
GO
ALTER DATABASE [NewsTest1] SET  READ_WRITE 
GO
