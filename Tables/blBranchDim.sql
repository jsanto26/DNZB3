/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct [branch_id]
      ,[branch_desc]
      ,[branch_code]
      ,[region_id]
      ,[area_id]
      ,[address_id]
  FROM [DFNB2].[dbo].[tblBranchDim]