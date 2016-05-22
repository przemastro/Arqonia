USE [master]
GO
/****** Object:  Database [Astro]    Script Date: 2016-05-22 17:11:42 ******/
CREATE DATABASE [Astro]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Astro', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Astro.mdf' , SIZE = 1024000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Astro_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Astro_log.ldf' , SIZE = 10240KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Astro] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Astro].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Astro] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Astro] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Astro] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Astro] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Astro] SET ARITHABORT OFF 
GO
ALTER DATABASE [Astro] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Astro] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Astro] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Astro] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Astro] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Astro] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Astro] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Astro] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Astro] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Astro] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Astro] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Astro] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Astro] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Astro] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Astro] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Astro] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Astro] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Astro] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Astro] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Astro] SET  MULTI_USER 
GO
ALTER DATABASE [Astro] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Astro] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Astro] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Astro] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Astro]
GO
/****** Object:  StoredProcedure [dbo].[observationsDelta]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[observationsDelta]
   
AS
BEGIN
   
   create table #tempTable
(
	[StarName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[UPhotometry] [bit] NULL,
	[VPhotometry] [bit] NULL,
	[BPhotometry] [bit] NULL,
)
   insert into #tempTable select StarName, StartDate, EndDate, UPhotometry, VPhotometry, BPhotometry from (
      select StarName, StartDate, EndDate, UPhotometry, VPhotometry, BPhotometry from dbo.StagingObservations
         except
      select StarName, StartDate, EndDate, UPhotometry, VPhotometry, BPhotometry from dbo.Observations) t

	  select * from #tempTable
	  drop table #tempTable
END
  




    
GO
/****** Object:  Table [dbo].[log]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[log](
	[ID] [int] NOT NULL,
	[ProcName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Message] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Observations]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Observations](
	[ID] [int] NOT NULL,
	[StarName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[UPhotometry] [bit] NULL,
	[VPhotometry] [bit] NULL,
	[BPhotometry] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StagingObservations]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StagingObservations](
	[ID] [int] NOT NULL,
	[StarName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[UPhotometry] [bit] NULL,
	[VPhotometry] [bit] NULL,
	[BPhotometry] [bit] NULL,
	[Active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tychoStaging]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tychoStaging](
	[ID] [int] NOT NULL,
	[NAME] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[observations_sorted]    Script Date: 2016-05-22 17:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[observations_sorted] AS
SELECT TOP (100) PERCENT ID AS id, StarName, StartDate, EndDate, UPhotometry, VPhotometry, BPhotometry
FROM  dbo.Observations
ORDER BY StartDate, EndDate
GO
USE [master]
GO
ALTER DATABASE [Astro] SET  READ_WRITE 
GO
