/********************************************************************************************
NAME: [dbo].[tblTransactionFact]
PURPOSE: Create the table [dbo].[tblTransactionFact]
SUPPORT: Jose Santos
	    jsanto26@ldsbc.edu
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/18/2019  JoseSantos   1. Built this script to create the table [dbo].[tblTransactionFact].
RUNTIME: 
NOTES: 
(...)
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/

USE [DFNB2]
GO

ALTER TABLE [dbo].[tblTransactionFact] DROP CONSTRAINT [FK_tblTransactionFact_tblTransaction_typeDim]
GO

ALTER TABLE [dbo].[tblTransactionFact] DROP CONSTRAINT [FK_tblTransactionFact_tblBranchDim]
GO

ALTER TABLE [dbo].[tblTransactionFact] DROP CONSTRAINT [FK_tblTransactionFact_tblAccountDim]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 11/18/2019 11:00:15 AM ******/
DROP TABLE [dbo].[tblTransactionFact]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 11/18/2019 11:00:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionFact](
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

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblAccountDim]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblBranchDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblBranchDim]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblTransaction_typeDim] FOREIGN KEY([tran_type_id])
REFERENCES [dbo].[tblTransaction_typeDim] ([tran_type_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblTransaction_typeDim]
GO


