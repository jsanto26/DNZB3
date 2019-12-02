CREATE VIEW vw_Trasbranch
AS
     SELECT DISTINCT 
            ctb.Branch_id
          , ctb.branch_desc
          , ctb.area_id
          , ctb.region_id
          , ctb.tran_date
          , ctb.tran_type_desc
          , ctb.tran_amt
          , ctb.tran_fee_amt
          , ctb.tran_fee_prct
       FROM dbo.vw_Custtransbranch AS ctb;