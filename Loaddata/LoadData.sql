  
/*****************************************************************************************************************
NAME:    LoadData
PURPOSE: ETL process for Example data
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/01/2019   Jose Santos       1. Built this Load Data for DNZB Project
1.1     11/18/2019   Jose Santos       2. Update this Load Data in 2 new tables
RUNTIME: 
Approx. 1 min
NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

--1) Create the Account Fact table

TRUNCATE TABLE dbo.tblAccountFact;

INSERT INTO dbo.tblAccountFact
SELECT DISTINCT 
       s.as_of_date
     , s.acct_id
     , s.cur_bal
  FROM dbo.stg_p1 AS s
 ORDER BY 1
        , 2;

-- 2) Create the Product Dimension table

TRUNCATE TABLE dbo.tblProductDim;

INSERT INTO dbo.tblProductDim
SELECT DISTINCT 
       s.prod_id
  FROM dbo.stg_p1 AS s;

-- 3) Create the Area Dimension table

TRUNCATE TABLE dbo.tblAreaDim;

INSERT INTO dbo.tblAreaDim
SELECT DISTINCT 
       s.acct_area_id AS area_id
  FROM dbo.stg_p1 AS s;


-- 4) Create the Region Dimension table

TRUNCATE TABLE dbo.tblRegionDim;

INSERT INTO dbo.tblRegionDim
SELECT DISTINCT 
       s.acct_region_id AS Region_id
  FROM dbo.stg_p1 AS s;

-- 5) Create the Address Dimension table--

TRUNCATE TABLE tblAddressDim;

INSERT INTO dbo.tblAddressDim(Address_id
                            , Address_type
                            , Latitude
                            , Longitude)
SELECT cust_add_id
     , cust_add_type
     , cust_add_lat
     , cust_add_lon
  FROM dbo.stg_p1
 GROUP BY cust_add_id
        , cust_add_type
        , cust_add_lat
        , cust_add_lon
 ORDER BY 1;

INSERT INTO dbo.tblAddressDim(Address_id
                            , Address_type
                            , Latitude
                            , Longitude)
SELECT acct_branch_add_id
     , acct_branch_add_type
     , acct_branch_add_lat
     , acct_branch_add_lon
  FROM dbo.stg_p1
 GROUP BY acct_branch_add_id
        , acct_branch_add_type
        , acct_branch_add_lat
        , acct_branch_add_lon
 ORDER BY 1;


-- 6) Create the  Account Dimension table--

TRUNCATE TABLE dbo.tblAccountDim;

INSERT INTO dbo.tblAccountDim
SELECT DISTINCT 
       s.acct_id
     , s.open_date
     , s.close_date
     , s.open_close_code
     , s.loan_amt
     , s.prod_id
     , s.branch_id
     , s.pri_cust_id
  FROM dbo.stg_p1 AS s;


-- 7) Create the  Customer Role Dimension table--

TRUNCATE TABLE dbo.tblCustomerRoleDim;

INSERT INTO dbo.tblCustomerRoleDim
SELECT DISTINCT 
       s.acct_cust_role_id AS Customer_role_id
  FROM dbo.stg_p1 AS s;

-- 8) Create the Customer Dimension table--

TRUNCATE TABLE dbo.tblCustomerDim;

INSERT INTO dbo.tblCustomerDim
SELECT DISTINCT 
       s.cust_id AS Customer_id
     , s.last_name
     , s.first_name
     , s.gender
     , s.birth_date
     , s.cust_since_date
     , s.cust_pri_branch_dist
     , s.pri_branch_id
     , s.acct_branch_add_id AS Address_id
     , s.cust_rel_id
  FROM dbo.stg_p1 AS s;

-- 9) Create the Customer Account Dimension table--

TRUNCATE TABLE dbo.tblCustomer_AccountDim;

INSERT INTO dbo.tblCustomer_AccountDim
SELECT DISTINCT 
       s.acct_id AS cust_acct_id
     , s.acct_id
     , s.cust_id
     , s.acct_cust_role_id
  FROM dbo.stg_p1 AS s
 WHERE acct_cust_role_id = 1;

-- 10) Create the Branch Dimension table--

TRUNCATE TABLE dbo.tblBranchDim;

INSERT INTO dbo.tblBranchDim
SELECT DISTINCT 
       s.branch_id
     , s.acct_branch_desc AS branch_desc
     , s.cust_add_id AS Address_id
     , s.acct_branch_code AS branch_code
     , s.acct_region_id AS region_id
     , s.acct_area_id AS area_id
  FROM dbo.stg_p1 AS s;

-- 11) Create the Relationship Dimension table--

TRUNCATE TABLE dbo.tblrelationshipDim;

INSERT INTO dbo.tblrelationshipDim
SELECT DISTINCT 
       s.cust_rel_id AS rel_id
  FROM dbo.stg_p1 AS s;

-- 12) Create the Transaction Fact table--
  WITH s1
     AS (SELECT DISTINCT 
                s.tran_date
              , s.tran_time
              , s.tran_fee_prct
              , s.tran_amt
              , s.tran_fee_amt
              , s.branch_id
              , s.acct_id
              , s.tran_type_id
           FROM dbo.stg_p2 AS s)
     INSERT INTO dbo.tblTransactionFact
     SELECT s1.tran_date
          , s1.tran_time
          , s1.tran_fee_prct
          , s1.tran_amt
          , s1.tran_fee_amt
          , s1.branch_id
          , s1.acct_id
          , s1.tran_type_id
       FROM s1;

-- 12) Create the Transaction Type Dimension table--
WITH s1
     AS (SELECT DISTINCT 
                s.tran_type_id
              , s.tran_type_code
              , s.tran_type_desc
              , s.cur_cust_req_ind
           FROM dbo.stg_p2 AS s)
     INSERT INTO dbo.tblTransaction_typeDim
     SELECT s1.tran_type_id
          , s1.tran_type_code
          , s1.tran_type_desc
          , s1.cur_cust_req_ind
       FROM s1;

/******************************************************************************************************************/
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
/******************************************************************************************************************/
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

/******************************************************************************************************************/
ALTER TABLE [dbo].[tblCustomerDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO

ALTER TABLE [dbo].[tblCustomerDim] CHECK CONSTRAINT [FK_tblCustomerDim_tblCustomerDim]
GO
/******************************************************************************************************************/
