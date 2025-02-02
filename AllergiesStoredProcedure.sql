
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Developer:	<Chinedu Ben>
-- Create date: <Jan 24 2025>
-- Description:	<Initial process to create stored procedure to pull Allergies Data >
-- 01/25/2025	<Adding parameter to the stored procedure using CATEGORY COLUMN >
-- =============================================
CREATE OR ALTER PROCEDURE spPullAllergiesData
	-- Add the parameters for the stored procedure here	
	@CATEGORY VARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [START]
      ,[STOP]
      ,[PATIENT]
      ,[ENCOUNTER]
      ,[CODE]
      ,[SYSTEM]
      ,[DESCRIPTION]
      ,[TYPE]
      ,[CATEGORY]
      ,[REACTION1]
      ,[DESCRIPTION1]
      ,[SEVERITY1] 
      ,[REACTION2]
      ,[DESCRIPTION2]
      ,[SEVERITY2]
  FROM [EmadeDev].[dbo].[allergies]
  WHERE CATEGORY=@CATEGORY
  
  End
  Go