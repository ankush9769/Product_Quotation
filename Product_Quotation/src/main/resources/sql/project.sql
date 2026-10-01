-- =========================================================
-- ForgeHub - MySQL 8.x Database Script
-- Converted from SQL Server script
-- =========================================================

CREATE DATABASE IF NOT EXISTS `forgehub`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `forgehub`;

SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------
-- Table: Users
-- ---------------------------------------------------------
DROP TABLE IF EXISTS `FinalizedQuotations`;
DROP TABLE IF EXISTS `RFQVendors`;
DROP TABLE IF EXISTS `RFQQuotations`;
DROP TABLE IF EXISTS `RFQItem`;
DROP TABLE IF EXISTS `RFQs`;
DROP TABLE IF EXISTS `Users`;

CREATE TABLE `Users` (
    `UserId` INT NOT NULL AUTO_INCREMENT,
    `FullName` LONGTEXT NOT NULL,
    `Email` LONGTEXT NOT NULL,
    `PasswordHash` LONGTEXT NOT NULL,
    `Role` LONGTEXT NOT NULL,
    `IsFirstTimeLogin` TINYINT(1) NOT NULL,
    `SecretKey` LONGTEXT NULL,
    PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Table: RFQs
-- ---------------------------------------------------------
CREATE TABLE `RFQs` (
    `RFQId` INT NOT NULL AUTO_INCREMENT,
    `RFQNo` LONGTEXT NOT NULL,
    `IndentNo` LONGTEXT NOT NULL,
    `RFQLineNo` LONGTEXT NULL,
    `ItemNo` LONGTEXT NULL,
    `ItemName` LONGTEXT NULL,
    `ReqQty` INT NULL,
    `Description` LONGTEXT NULL,
    `DeliveryLocation` LONGTEXT NULL,
    `UOM` LONGTEXT NULL,
    `ReqDeliveryDate` DATETIME(6) NULL,
    `FactoryCode` LONGTEXT NULL,
    `BidDate` DATETIME(6) NULL,
    `ExpiryDateofBid` DATETIME(6) NULL,
    `Mobile` LONGTEXT NULL,
    `ContactPerson` LONGTEXT NULL,
    `Status` LONGTEXT NULL,
    `UserId` INT NOT NULL,
    PRIMARY KEY (`RFQId`),
    KEY `IX_RFQs_UserId` (`UserId`),
    CONSTRAINT `FK_RFQs_Users_UserId`
        FOREIGN KEY (`UserId`) REFERENCES `Users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Table: RFQItem
-- ---------------------------------------------------------
CREATE TABLE `RFQItem` (
    `ItemId` INT NOT NULL AUTO_INCREMENT,
    `RFQId` INT NOT NULL,
    `RFQLineNo` LONGTEXT NOT NULL,
    `ItemNo` LONGTEXT NOT NULL,
    `ItemName` LONGTEXT NOT NULL,
    `ReqQty` INT NOT NULL,
    `UOM` LONGTEXT NOT NULL,
    `ReqDeliveryDate` DATETIME(6) NOT NULL,
    `DeliveryLocation` LONGTEXT NULL,
    `Description` LONGTEXT NULL,
    `FactoryCode` LONGTEXT NULL,
    PRIMARY KEY (`ItemId`),
    KEY `IX_RFQItem_RFQId` (`RFQId`),
    CONSTRAINT `FK_RFQItem_RFQs_RFQId`
        FOREIGN KEY (`RFQId`) REFERENCES `RFQs` (`RFQId`)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Table: RFQQuotations
-- ---------------------------------------------------------
CREATE TABLE `RFQQuotations` (
    `QuotationId` INT NOT NULL AUTO_INCREMENT,
    `BidNo` LONGTEXT NULL,
    `QuotedAmount` DECIMAL(18,4) NULL,
    `DeliveryDate` DATETIME(6) NOT NULL,
    `PaymentTerms` LONGTEXT NULL,
    `Remarks` LONGTEXT NULL,
    `Status` LONGTEXT NULL,
    `SubmittedDate` DATETIME(6) NULL,
    `RFQId` INT NOT NULL,
    `VendorId` INT NOT NULL,
    PRIMARY KEY (`QuotationId`),
    KEY `IX_RFQQuotations_RFQId` (`RFQId`),
    KEY `IX_RFQQuotations_VendorId` (`VendorId`),
    CONSTRAINT `FK_RFQQuotations_RFQs_RFQId`
        FOREIGN KEY (`RFQId`) REFERENCES `RFQs` (`RFQId`),
    CONSTRAINT `FK_RFQQuotations_Users_VendorId`
        FOREIGN KEY (`VendorId`) REFERENCES `Users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Table: RFQVendors
-- ---------------------------------------------------------
CREATE TABLE `RFQVendors` (
    `Id` INT NOT NULL AUTO_INCREMENT,
    `RFQId` INT NOT NULL,
    `VendorId` INT NOT NULL,
    PRIMARY KEY (`Id`),
    KEY `IX_RFQVendors_RFQId` (`RFQId`),
    KEY `IX_RFQVendors_VendorId` (`VendorId`),
    CONSTRAINT `FK_RFQVendors_RFQs_RFQId`
        FOREIGN KEY (`RFQId`) REFERENCES `RFQs` (`RFQId`)
        ON DELETE CASCADE,
    CONSTRAINT `FK_RFQVendors_Users_VendorId`
        FOREIGN KEY (`VendorId`) REFERENCES `Users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Table: FinalizedQuotations
-- ---------------------------------------------------------
CREATE TABLE `FinalizedQuotations` (
    `FinalId` INT NOT NULL AUTO_INCREMENT,
    `FinalizedDate` DATETIME(6) NULL,
    `RFQId` INT NOT NULL,
    `QuotationId` INT NOT NULL,
    PRIMARY KEY (`FinalId`),
    UNIQUE KEY `IX_FinalizedQuotations_QuotationId` (`QuotationId`),
    UNIQUE KEY `IX_FinalizedQuotations_RFQId` (`RFQId`),
    CONSTRAINT `FK_FinalizedQuotations_RFQQuotations_QuotationId`
        FOREIGN KEY (`QuotationId`) REFERENCES `RFQQuotations` (`QuotationId`),
    CONSTRAINT `FK_FinalizedQuotations_RFQs_RFQId`
        FOREIGN KEY (`RFQId`) REFERENCES `RFQs` (`RFQId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- End of ForgeHub MySQL script
-- =========================================================
