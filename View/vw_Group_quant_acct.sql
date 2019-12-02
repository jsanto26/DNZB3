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
CREATE VIEW vw_Group_quant_acct
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
        