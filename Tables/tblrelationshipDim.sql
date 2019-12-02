/*****************************************************************************************************************
NAME:    dbo.tblrelationshipDim
PURPOSE: Create the dbo.tblrelationshipDim table
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/28/2019   Jose Santos       1. Built this table DNBZ Project
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

/****** Object:  Table [dbo].[tblrelationshipDim]    Script Date: 10/30/2019 9:54:20 PM ******/
DROP TABLE [dbo].[tblrelationshipDim]
GO

/****** Object:  Table [dbo].[tblrelationshipDim]    Script Date: 10/30/2019 9:54:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblrelationshipDim](
	[rel_id] [smallint] NOT NULL,
	[rel_desc] [varchar](50) NULL,
 CONSTRAINT [PK_tblrelationshipDim] PRIMARY KEY CLUSTERED 
(
	[rel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


