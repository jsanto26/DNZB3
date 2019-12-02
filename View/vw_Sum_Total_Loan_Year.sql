CREATE VIEW vw_Sum_Total_Loan_Year
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
     