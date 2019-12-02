/********************************************************************************************
NAME: [dbo].[vw_Custtransbranch]
PURPOSE: Create the view [dbo].[vw_Custtransbranch]
SUPPORT: Jose Santos
	  
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/18/2019  Jose Santos  1. Built this script to create the view [dbo].[vw_Custtransbranch].
RUNTIME: 
1 min
NOTES: 
This view connect branch, account, custumer, and differents types of transactions.
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/
CREATE VIEW vw_Custtransbranch
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