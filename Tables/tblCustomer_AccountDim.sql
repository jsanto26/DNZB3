/*****************************************************************************************************************
NAME:    dbo.tblCustomer_AccountDim
PURPOSE: Create the dbo.tblCustomer_AccountDim table
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/30/2019   Jose Santos       1. Built this table DNBZ Project
RUNTIME: 
Approx. 0 min
NOTES:
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/
USE [DFNB2]
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim] DROP CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerRoleDim]
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim] DROP CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerDim]
GO

/****** Object:  Table [dbo].[tblCustomer_AccountDim]    Script Date: 10/30/2019 10:39:52 PM ******/
DROP TABLE [dbo].[tblCustomer_AccountDim]
GO

/****** Object:  Table [dbo].[tblCustomer_AccountDim]    Script Date: 10/30/2019 10:39:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCustomer_AccountDim](
	[cust_acct_id] [int] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[acct_cust_role_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomer_AccountDim] PRIMARY KEY CLUSTERED 
(
	[cust_acct_id] ASC,
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim] CHECK CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerDim]
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerRoleDim] FOREIGN KEY([acct_cust_role_id])
REFERENCES [dbo].[tblCustomerRoleDim] ([Customer_role_id])
GO

ALTER TABLE [dbo].[tblCustomer_AccountDim] CHECK CONSTRAINT [FK_tblCustomer_AccountDim_tblCustomerRoleDim]
GO


