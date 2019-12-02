/********************************************************************************************
NAME: [dbo].[vw_Avg_Total_Loan_Year]
PURPOSE: Create the view [dbo].[vw_Avg_Total_Loan_Year]
SUPPORT: Jose Santos
	  
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   12/01/2019  Jose Santos  1. Creating New View vw_Avg_Total_Loan_Year
RUNTIME: 
1 min
NOTES: 
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/

CREATE VIEW vw_Avg_Total_Loan_Year
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
			



