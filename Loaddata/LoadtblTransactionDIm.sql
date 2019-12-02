

/*SELECT DISTINCT 
       tran_type_id
     , tran_type_code
     , tran_type_desc
INTO dbo.tblTransaction_typeDim
  FROM dbo.stg_p2;

  TRUNCATE TABLE dbo.tblTransaction_typeDim;

CREATE TABLE dbo.tblTransactionFact
(tran_id       INT IDENTITY(1001, 1)
, tran_date     DATE NOT NULL
, tran_time     TIME(7) NOT NULL
, tran_fee_prct DECIMAL(4, 3) NOT NULL
, tran_amt      INT NOT NULL
, tran_fee_amt  DECIMAL(15, 3) NOT NULL
, branch_id     SMALLINT NOT NULL
, acct_id       INT NOT NULL
, tran_type_id  SMALLINT NOT NULL
);
	


CREATE TABLE dbo.my_table(
	tran_type_id bigint identity(1001,1),
	tran_type_code varchar(5) NOT NULL,
);

WITH s1
AS
(
SELECT DISTINCT s.tran_type_code
 FROM dbo.stg_p2 as s
 )
 INSERT INTO dbo.my_table
 SELECT s1.tran_type_code
   FROM s1 
   ORDER BY 1;*/


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
     INSERT INTO dbo.tblTransactionDim
     SELECT s1.tran_date
          , s1.tran_time
          , s1.tran_fee_prct
          , s1.tran_amt
          , s1.tran_fee_amt
          , s1.branch_id
          , s1.acct_id
          , s1.tran_type_id
       FROM s1;
      