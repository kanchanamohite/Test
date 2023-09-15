
CREATE PROCEDURE [dbo].[usp_DimLoadUserDetails]
AS
BEGIN
	TRUNCATE TABLE Dimension.UserDetails

	INSERT INTO Dimension.UserDetails
	SELECT U.UstoreUserID
		,NULLIF(U.UserFirstName, '') AS FirstName
		,NULLIF(U.UserLastName, '') AS LastName
		,CONCAT (
			U.UserFirstName
			,' ' + U.UserLastName
			) AS OrderUser
		,U.UserEmail AS Email
		,U.UserDepartment AS Department
		,U.HaleonLocation
	FROM [LZ_SodexoHaleon].[dbo].[User] U
	WHERE U.IsDeleted = 0
END
