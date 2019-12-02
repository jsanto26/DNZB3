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
       FROM s1

CREATE TABLE dbo.tblTransaction_typeDim
(tran_type_id     SMALLINT NOT NULL
, tran_type_code   VARCHAR(5) NOT NULL
, tran_type_desc   VARCHAR(100) NOT NULL
, cur_cust_req_ind VARCHAR(1) NOT NULL
);


