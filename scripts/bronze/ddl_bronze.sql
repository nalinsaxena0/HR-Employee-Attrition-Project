
USE master;
GO

-- Drop and recreate the 'EmAt' database.
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'EmAt')
BEGIN
	ALTER DATABASE EmAt SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE EmAt;
END;
GO

CREATE DATABASE EmAt;
GO

USE EmAt;
GO

-- Create schemas.
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
