﻿CREATE PROCEDURE [Website].[CitiesUpdateFromJson](@CitiesJson NVARCHAR(MAX), @CityID int,@UserID int)
WITH EXECUTE AS OWNER
AS BEGIN
	UPDATE Application.Cities SET
		CityName = json.CityName,
		StateProvinceID = json.StateProvinceID,
		LatestRecordedPopulation = json.LatestRecordedPopulation,
		LastEditedBy = @UserID
	FROM OPENJSON (@CitiesJson)
		WITH (
			CityName nvarchar(50) N'strict $.CityName',
			StateProvinceID int N'strict $.StateProvinceID',
			LatestRecordedPopulation bigint) as json
	WHERE 
		Application.Cities.CityID = @CityID

END