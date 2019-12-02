/********************************************************************************************
NAME: [dbo].[tblTransaction_typeDim]
PURPOSE: Create the table [dbo].[tblTransaction_typeDim]
SUPPORT: Jose Santos
	    jsanto26@ldsbc.edu
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/18/2019  JoseSantos   1. Built this script to create the table [dbo].[tblTransaction_typeDim].
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

/****** Object:  Table [dbo].[tblTransaction_typeDim]    Script Date: 11/18/2019 10:50:57 AM ******/
DROP TABLE [dbo].[tblTransaction_typeDim]
GO

/****** Object:  Table [dbo].[tblTransaction_typeDim]    Script Date: 11/18/2019 10:50:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransaction_typeDim](
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblTransaction_typeDim] PRIMARY KEY CLUSTERED 
(
	[tran_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


