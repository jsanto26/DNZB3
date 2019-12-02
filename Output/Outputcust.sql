/********************************************************************************************
NAME: DataOutput
PURPOSE: Creating Reports by Output Data
SUPPORT: Jose Santos
	    
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/03/2019  Jose Santos   1. Build Output Data.
1.0   12/01/2019  Jose Santos   2. Updated Output Data with new group of quantity account per Customers
RUNTIME: 
1 min
NOTES: 

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/
 1)SELECT DISTINCT 
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
                             )
 GROUP BY branch_desc
        , YEAR(as_of_date)
        , ad.branch_id;
********************************************************************************************/
2)SELECT DISTINCT 
       cd.cust_id
     , ca.acct_id
     , cd.gender
     , YEAR(ad.open_date) AS Start_Year
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
********************************************************************************************/
3)SELECT DISTINCT 
       cust_id
     , acct_id
     , gender
     , Start_Year
     , Status_Account
     , Birth_month
     , Years_Client
     , Age
     , Branch_id
  FROM DFNB2.dbo.vw_Customer;
********************************************************************************************/  
 4)SELECT DISTINCT 
       cust_id
     , acct_id
     , first_name
     , last_name
     , gender
     , Cust_since
     , Status_Account
     , Birth_month
     , Years_Client
     , Age
     , Branch_id
     , Customer_role_id
  FROM DFNB2.dbo.vw_Customers_Accounts;

********************************************************************************************/ 
5)SELECT cust_id
     , Quantity_acct
     , Group_Category
  FROM DFNB2.dbo.vw_Group_quant_acct
 ORDER BY group_category ASC;

