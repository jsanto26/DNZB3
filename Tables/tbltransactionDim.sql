USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblTransactionDim]    Script Date: 11/16/2019 9:59:39 PM ******/
DROP TABLE [dbo].[tblTransactionDim]
GO

/****** Object:  Table [dbo].[tblTransactionDim]    Script Date: 11/16/2019 9:59:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionDim](
	[tran_id] [int] IDENTITY(1001,1) NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_time] [time](7) NOT NULL,
	[tran_fee_prct] [decimal](4, 3) NOT NULL,
	[tran_amt] [int] NOT NULL,
	[tran_fee_amt] [decimal](15, 3) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
	[tran_type_id] [smallint] NOT NULL
) ON [PRIMARY]
GO


