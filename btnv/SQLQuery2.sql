USE TOYS
GO
CREATE TABLE TOYS (
    ProductCode VARCHAR(5) PRIMARY KEY,
    Name VARCHAR(30),
    Category VARCHAR(30),
    Manufacturer VARCHAR(40),
    AgeRange VARCHAR(15), 
    UnitPrice money,
    Netweight INT,
    QtyOnHand INT
);

INSERT INTO TOYS (ProductCode, Name, Category, Manufacturer, AgeRange, UnitPrice, Netweight, QtyOnHand)
VALUES 
    ('TC001', 'Teddy Bear', 'Plush Toys', 'ABC Toys', '3+', 9.99, 200, 25),
    ('CA002', 'Car Toy', 'Remote Control Toys', 'XYZ Toys', '6+', 19.99, 150, 30),
    ('DB003', 'Dollhouse', 'Dolls & Accessories', '123 Toys', '5+', 49.99, 800, 40),
    ('PB004', 'Puzzle Box', 'Educational Toys', 'DEF Toys', '8+', 14.99, 400, 35),
    ('BB005', 'Building Blocks', 'Construction Toys', 'GHI Toys', '3+', 29.99, 600, 50),
    ('RT006', 'Robot Toy', 'Electronic Toys', 'LMN Toys', '10+', 39.99, 1000, 60),
    ('ST007', 'Stuffed Animal Set', 'Plush Toys', 'OPQ Toys', '3+', 24.99, 300, 25),
    ('FP008', 'Finger Puppet', 'Puppets', 'RST Toys', '3+', 9.99, 50, 20),
    ('TT009', 'Teething Toy', 'Baby Toys', 'UVW Toys', '0+', 7.99, 100, 30),
    ('DG010', 'Doctor Set', 'Role Play Toys', 'XYZ Toys', '3+', 19.99, 400, 40),
    ('GB011', 'Guitar Toy', 'Musical Toys', 'ABC Toys', '6+', 24.99, 200, 45),
    ('SC012', 'Science Kit', 'Educational Toys', 'DEF Toys', '8+', 29.99, 500, 50),
    ('RC013', 'Remote Control Helicopter', 'Remote Control Toys', 'GHI Toys', '10+', 49.99, 300, 55),
    ('TT014', 'Train Set', 'Vehicle Toys', 'LMN Toys', '3+', 34.99, 800, 60),
    ('SD015', 'Superhero Costume', 'Dress Up Toys', 'OPQ Toys', '5+', 19.99, 250, 25);

CREATE PROCEDURE HeavyToys
AS
BEGIN
    SELECT *
    FROM TOYS
    WHERE Netweight > 500;
END

CREATE PROCEDURE PriceIncrease
AS
BEGIN
    UPDATE TOYS
    SET UnitPrice = UnitPrice + 10;
END
CREATE PROCEDURE QtyOnHand
AS
BEGIN
    UPDATE TOYS
    SET QtyOnHand = QtyOnHand - 5;
END
EXEC HeavyToys;
EXEC PriceIncrease;
EXEC QtyOnHand;
SELECT definition 
FROM sys.sql_modules 
WHERE object_id = OBJECT_ID('HeavyToys');

SELECT definition 
FROM sys.sql_modules 
WHERE object_id = OBJECT_ID('PriceIncrease');

SELECT definition 
FROM sys.sql_modules 
WHERE object_id = OBJECT_ID('QtyOnHand');

EXEC sp_depends 'HeavyToys';
EXEC sp_depends 'PriceIncrease';
EXEC sp_depends 'QtyOnHand';
CREATE OR ALTER PROCEDURE QtyOnHand
AS
BEGIN

    UPDATE YourTable
    SET QtyOnHand = QtyOnHand + 10;

    SELECT QtyOnHand
    FROM YourTable
END;
CREATE PROCEDURE SpecificPriceIncrease
AS
BEGIN
    DECLARE @TotalQtyOnHand INT;

    SELECT @TotalQtyOnHand = SUM(QtyOnHand)
    FROM Toys;

    UPDATE Toys
    SET UnitPrice = UnitPrice + @TotalQtyOnHand;

    SELECT *
    FROM Toys;
END;
GO
EXEC SpecificPriceIncrease;
ALTER PROCEDURE SpecificPriceIncrease
AS
BEGIN
    DECLARE @TotalQtyOnHand INT;

    SELECT @TotalQtyOnHand = SUM(QtyOnHand)
    FROM Toys;

    UPDATE Toys
    SET UnitPrice = UnitPrice + @TotalQtyOnHand;

    SELECT *,
           @TotalQtyOnHand AS TotalUpdatedRecords
    FROM Toys;
END;
GO
ALTER PROCEDURE HeavyToys
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM Toys
        WHERE Netweight > 500;
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while executing HeavyToys procedure.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
ALTER PROCEDURE PriceIncrease
AS
BEGIN
    BEGIN TRY
        UPDATE Toys
        SET UnitPrice = UnitPrice + 10;
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while executing PriceIncrease procedure.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
ALTER PROCEDURE QtyOnHand
AS
BEGIN
    BEGIN TRY
        UPDATE Toys
        SET QtyOnHand = QtyOnHand - 5
        WHERE DATEPART(WEEKDAY, GETDATE()) = 5;
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while executing QtyOnHand procedure.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
DROP PROCEDURE HeavyToys;
DROP PROCEDURE PriceIncrease;
DROP PROCEDURE QtyOnHand;
DROP PROCEDURE SpecificPriceIncrease;