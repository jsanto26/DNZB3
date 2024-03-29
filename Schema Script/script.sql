USE [DFNB2]
GO
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 12/1/2019 10:29:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountFact](
	[as_of_date] [date] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL,
 CONSTRAINT [PK_tblAccountFact] PRIMARY KEY CLUSTERED 
(
	[as_of_date] ASC,
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerRoleDim]    Script Date: 12/1/2019 10:29:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerRoleDim](
	[Customer_role_id] [smallint] NOT NULL,
	[cut_role_desc] [varchar](50) NULL,
 CONSTRAINT [PK_tblCustomerRoleDim] PRIMARY KEY CLUSTERED 
(
	[Customer_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 12/1/2019 10:29:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountDim](
	[acct_id] [int] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
	[prod_id] [smallint] NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[pri_cust_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblAccountDim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomer_AccountDim]    Script Date: 12/1/2019 10:29:59 PM ******/
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
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerDim](
	[cust_id] [smallint] NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
	[cust_pri_branch_dist] [decimal](7, 2) NOT NULL,
	[Branch_id] [smallint] NOT NULL,
	[Address_id] [int] NOT NULL,
	[rel_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomerDim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Customer]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2) Total of Existents Customers and New Customers (2019)
CREATE VIEW [dbo].[vw_Customer]
As
SELECT DISTINCT 
       cd.cust_id
     , ca.acct_id
     , cd.gender
     , Year(ad.open_date) AS Start_Year
     , ad.open_close_code AS Status_Account
     , DATENAME(M, cd.birth_date) AS Birth_month
     , DATEDIFF(Month, cd.cust_since_date, GETDATE()) / 12 AS Years_Client
     , DATEDIFF(Month, cd.birth_date, GETDATE()) / 12 AS Age
     , cd.Branch_id
  FROM dbo.tblCustomerDim AS cd
       INNER JOIN
       dbo.tblCustomer_AccountDim AS ca ON cd.cust_id = ca.cust_id
       INNER JOIN
       dbo.tblAccountFact AS af ON ca.acct_id = af.acct_id
       INNER JOIN
       dbo.tblAccountDim AS ad ON af.acct_id = ad.acct_id
       INNER JOIN
       dbo.tblCustomerRoleDim AS cr ON ca.acct_cust_role_id = cr.Customer_role_id
 GROUP BY cd.gender
        , ad.open_date
        , cd.cust_id
        , cd.cust_since_date
        , cd.birth_date
        , cd.cust_since_date
        , cd.birth_date
        , cd.Branch_id
        , ca.acct_id
        , af.as_of_date
        , af.cur_bal
        , ad.open_close_code
        , cr.Customer_role_id
        , cd.first_name
        , cd.last_name;
GO
/****** Object:  View [dbo].[vw_Customers_Accounts]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2) Total of Existents Customers and New Customers (2019)

CREATE VIEW [dbo].[vw_Customers_Accounts]
AS
     SELECT DISTINCT
     --Count(cd.cust_id)as Quantity_ID,
            cd.cust_id
          , ca.acct_id
          , cd.first_name
          , cd.last_name
          , cd.gender
            --af.cur_bal,
            --af.as_of_date,
          , YEAR(cd.cust_since_date) AS Cust_since
          , ad.open_close_code AS Status_Account
          , DATENAME(M, cd.birth_date) AS Birth_month
          , DATEDIFF(Month, cd.cust_since_date, GETDATE()) / 12 AS Years_Client
          , DATEDIFF(Month, cd.birth_date, GETDATE()) / 12 AS Age
          , cd.Branch_id
          , cr.Customer_role_id
       FROM dbo.tblCustomerDim AS cd
            INNER JOIN
            dbo.tblCustomer_AccountDim AS ca ON cd.cust_id = ca.cust_id
            INNER JOIN
            dbo.tblAccountFact AS af ON ca.acct_id = af.acct_id
            INNER JOIN
            dbo.tblAccountDim AS ad ON af.acct_id = ad.acct_id
            INNER JOIN
            dbo.tblCustomerRoleDim AS cr ON ca.acct_cust_role_id = cr.Customer_role_id
      --WHERE YEAR (af.cur_bal),
      GROUP BY cd.gender
             , cd.cust_id
             , cd.cust_since_date
             , cd.birth_date
             , cd.cust_since_date
             , cd.birth_date
             , cd.Branch_id
             , ca.acct_id
             , af.as_of_date
             , af.cur_bal
             , ad.open_close_code
             , cr.Customer_role_id
             , cd.first_name
             , cd.last_name;
GO
/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 12/1/2019 10:30:00 PM ******/
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
	[tran_type_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblTransactionFact] PRIMARY KEY CLUSTERED 
(
	[tran_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTransaction_typeDim]    Script Date: 12/1/2019 10:30:00 PM ******/
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
/****** Object:  View [dbo].[vw_Custtransbranch]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Custtransbranch]
AS
     SELECT DISTINCT 
            tf.branch_id
          , tt.tran_type_code
          , tt.tran_type_desc
          , tt.cur_cust_req_ind
          , tf.tran_id
          , tf.tran_date
          , tf.tran_time
          , tf.tran_fee_prct
          , tf.tran_amt
          , tf.tran_fee_amt
       FROM dbo.tblTransactionFact AS tf
            JOIN
            dbo.tblTransaction_typeDim AS tt ON tt.tran_type_id = tf.tran_type_id
      GROUP BY tf.branch_id
             , tt.tran_type_code
             , tt.tran_type_desc
             , tt.cur_cust_req_ind
             , tf.tran_id
             , tf.tran_date
             , tf.tran_time
             , tf.tran_fee_prct
             , tf.tran_amt
             , tf.tran_fee_amt;
GO
/****** Object:  View [dbo].[vw_Group_quant_acct]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************************************
NAME: [dbo].[vw_Group_quant_acct]
PURPOSE: Create the view [dbo].[vw_Group_quant_acct]
SUPPORT: Jose Santos
	  
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   12/01/2019  Jose Santos  1. Creating New View based the need of grouping with many accounts 
[dbo].[vw_Group_quant_acct].
RUNTIME: 
1 min
NOTES: 
This view helping to separed 2 groups of customers with quantities of many accounts.
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/
CREATE VIEW [dbo].[vw_Group_quant_acct]
AS
     WITH S1
          AS (SELECT v.cust_id
                   , COUNT(v.acct_id) AS Quantity_acct
                FROM DFNB2.dbo.vw_Customers_Accounts AS v
               GROUP BY v.cust_id)
          SELECT s.cust_id
               , s.Quantity_acct
               , CASE
                     WHEN s.Quantity_acct > 150
                     THEN 'Group A'
                     ELSE 'Group B'
                 END AS Group_Category
            FROM S1 AS s
        
GO
/****** Object:  Table [dbo].[tblBranchDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBranchDim](
	[branch_id] [smallint] NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[region_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
	[address_id] [int] NULL,
 CONSTRAINT [PK_tblBranchDim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Sum_Total_Loan_Year]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Sum_Total_Loan_Year]
AS
     SELECT DISTINCT 
            ad.branch_id
          , b.branch_desc AS Branch_desc
          , SUM(ad.loan_amt) AS Total_Loan
          , YEAR(as_of_date) AS Year
       FROM tblAccountDim AS ad
            INNER JOIN
            dbo.tblBranchDim AS b ON b.branch_id = ad.branch_id
            INNER JOIN
            dbo.tblAccountFact AS af ON ad.acct_id = af.acct_id
      WHERE YEAR(af.as_of_date) IN
                                  (
                                   2019
                                 , 2018
                                 , 2017
                                 , 2016
                                 , 2015
                                 , 2014
                                 , 2013
                                 , 2012
                                 , 2011
                                 , 2010
                                  )
      GROUP BY branch_desc
             , YEAR(as_of_date)
             , ad.branch_id;
     
GO
/****** Object:  View [dbo].[vw_Avg_Total_Loan_Year]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1) How much are the loans in years (2019, 2018, 2017, 2016)? trocar avg max

CREATE VIEW [dbo].[vw_Avg_Total_Loan_Year]
AS
     SELECT DISTINCT 
            ad.branch_id
          , b.branch_desc AS Branch_desc
          , avg(ad.loan_amt) AS Total_Loan
          , YEAR(as_of_date) AS Year
       FROM tblAccountDim AS ad
            INNER JOIN
            dbo.tblBranchDim AS b ON b.branch_id = ad.branch_id
            INNER JOIN
            dbo.tblAccountFact AS af ON ad.acct_id = af.acct_id
      WHERE YEAR(af.as_of_date) IN
                                  (
                                   2019
                                 , 2018
                                 , 2017
                                 , 2016
								 , 2015
                                 , 2014
                                 , 2013
                                 , 2012
                                 , 2011
                                 , 2010
                                  )
      GROUP BY branch_desc
             , YEAR(as_of_date)
             , ad.branch_id
			



GO
/****** Object:  View [dbo].[vw_Max_Total_Loan_Year]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Max_Total_Loan_Year]
AS
     SELECT DISTINCT 
            ad.branch_id
          , b.branch_desc AS Branch_desc
          , Max(ad.loan_amt) AS Total_Loan
          , YEAR(as_of_date) AS Year
       FROM tblAccountDim AS ad
            INNER JOIN
            dbo.tblBranchDim AS b ON b.branch_id = ad.branch_id
            INNER JOIN
            dbo.tblAccountFact AS af ON ad.acct_id = af.acct_id
      WHERE YEAR(af.as_of_date) IN
                                  (
                                   2019
                                 , 2018
                                 , 2017
                                 , 2016
                                 , 2015
                                 , 2014
                                 , 2013
                                 , 2012
                                 , 2011
                                 , 2010
                                  )
      GROUP BY branch_desc
             , YEAR(as_of_date)
             , ad.branch_id;
     
GO
/****** Object:  Table [dbo].[stg_p1]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_p1](
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[acct_cust_role_id] [smallint] NOT NULL,
	[acct_id2] [int] NOT NULL,
	[prod_id] [smallint] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[acct_rel_id] [smallint] NOT NULL,
	[pri_cust_id] [smallint] NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
	[acct_branch_id] [smallint] NOT NULL,
	[acct_branch_code] [varchar](5) NOT NULL,
	[acct_branch_desc] [varchar](100) NOT NULL,
	[acct_region_id] [int] NOT NULL,
	[acct_area_id] [int] NOT NULL,
	[acct_branch_lat] [decimal](16, 12) NOT NULL,
	[acct_branch_lon] [decimal](16, 12) NOT NULL,
	[acct_branch_add_id] [int] NOT NULL,
	[acct_branch_add_lat] [decimal](16, 12) NOT NULL,
	[acct_branch_add_lon] [decimal](16, 12) NOT NULL,
	[acct_branch_add_type] [varchar](1) NOT NULL,
	[cust_id2] [smallint] NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
	[pri_branch_id] [smallint] NOT NULL,
	[cust_pri_branch_dist] [decimal](7, 2) NOT NULL,
	[cust_lat] [decimal](16, 12) NOT NULL,
	[cust_lon] [decimal](16, 12) NOT NULL,
	[cust_rel_id] [smallint] NOT NULL,
	[cust_add_id] [int] NOT NULL,
	[cust_add_lat] [decimal](16, 12) NOT NULL,
	[cust_add_lon] [decimal](16, 12) NOT NULL,
	[cust_add_type] [varchar](1) NOT NULL,
	[as_of_date] [date] NOT NULL,
	[acct_id3] [int] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_p2]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_p2](
	[branch_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_time] [time](7) NOT NULL,
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
	[tran_fee_prct] [decimal](4, 3) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL,
	[tran_amt] [int] NOT NULL,
	[tran_fee_amt] [decimal](15, 3) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAddressDim](
	[Address_id] [int] NOT NULL,
	[Address_type] [varchar](1) NOT NULL,
	[Latitude] [decimal](16, 12) NOT NULL,
	[Longitude] [decimal](16, 12) NOT NULL,
 CONSTRAINT [PK_tblAddressDim] PRIMARY KEY CLUSTERED 
(
	[Address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAreaDim](
	[area_id] [int] NOT NULL,
	[area_desc] [varchar](50) NULL,
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED 
(
	[area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDim](
	[prod_id] [smallint] NOT NULL,
	[prod_desc] [varchar](50) NULL,
 CONSTRAINT [PK_tblProductDim] PRIMARY KEY CLUSTERED 
(
	[prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegionDim](
	[Region_id] [int] NOT NULL,
	[Region_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblRegionDim] PRIMARY KEY CLUSTERED 
(
	[Region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblrelationshipDim]    Script Date: 12/1/2019 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblrelationshipDim](
	[rel_id] [smallint] NOT NULL,
	[rel_des] [varchar](50) NULL,
 CONSTRAINT [PK_tblrelationshipDim] PRIMARY KEY CLUSTERED 
(
	[rel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblBranchDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblBranchDim]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblProductDim] FOREIGN KEY([prod_id])
REFERENCES [dbo].[tblProductDim] ([prod_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblProductDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblAddressDim] FOREIGN KEY([address_id])
REFERENCES [dbo].[tblAddressDim] ([Address_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblAddressDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblAreaDim] FOREIGN KEY([area_id])
REFERENCES [dbo].[tblAreaDim] ([area_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblAreaDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblBranchDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblBranchDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblRegionDim] FOREIGN KEY([region_id])
REFERENCES [dbo].[tblRegionDim] ([Region_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblRegionDim]
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
ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblAddressDim] FOREIGN KEY([Address_id])
REFERENCES [dbo].[tblAddressDim] ([Address_id])
GO
ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblAddressDim]
GO
ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblBranchDim] FOREIGN KEY([Branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblBranchDim]
GO
ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO
ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblCustomerDim]
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
