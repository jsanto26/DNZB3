--2) Total of Existents Customers and New Customers (2019)

CREATE VIEW vw_Customers_Accounts
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