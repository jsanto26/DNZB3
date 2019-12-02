/********************************************************************************************
NAME: [dbo].[vw_Transbranchtotal]
PURPOSE: Create the view [dbo].[vw_Transbranchtotal]
SUPPORT: Jose Santos
	  
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/18/2019  Jose Santos  1. Built this script to create the view [dbo].[vw_Transbranchtotal].
RUNTIME: 
1 min
NOTES: 
This view connect total of branch, account,and differents types of transactions.
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/
CREATE VIEW vw_Transbranchtotal
AS
     SELECT DISTINCT 
            tf.tran_id
          , tf.tran_date
          , tf.tran_time
          , tf.tran_fee_prct
          , tf.tran_fee_amt
          , tf.branch_id
          , tf.acct_id
          , t.tran_type_id
          , t.tran_type_code
          , t.tran_type_desc
          , t.cur_cust_req_ind
       FROM dbo.tblTransaction_typeDim AS t
            INNER JOIN
            dbo.tblTransactionFact AS tf ON t.tran_type_id = tf.tran_type_id
            INNER JOIN
            dbo.tblBranchDim AS b ON tf.branch_id = b.branch_id;