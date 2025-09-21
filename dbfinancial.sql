
-- 01_CREATE_DATABASE
CREATE DATABASE dbfinancial;

USE dbfinancial;

-- O2_CREATE_TABLES

CREATE TABLE Users (
	user_id INT IDENTITY(1,1) PRIMARY KEY,
	username VARCHAR(100) NOT NULL,
	password VARCHAR(200) NOT NULL
);

CREATE TABLE Bank_accounts (
	account_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT FOREIGN KEY REFERENCES Users(user_id),
	name_bank VARCHAR(100) NOT NULL,
	ubication VARCHAR(100),
	total_quantity DECIMAL(10, 2) NOT NULL
)

CREATE TABLE Categories (
	category_id INT IDENTITY(1,1) PRIMARY KEY,
	account_id INT FOREIGN KEY REFERENCES Bank_accounts(account_id),
	category_name VARCHAR(100) NOT NULL,
	priority_level INT NOT NULL CHECK (priority_level > 0 and priority_level < 4), -- ONLY BETWEEN 1 TO 3
	is_recurring BIT NOT NULL, -- YES OR NO
	detail_type VARCHAR(20) NOT NULL, -- DEBT, SAVING, PERSONAL, INVEST (YOU CAN KNOW THIS INFORMATION IF IT'S INCOME OR OUTCOME)
);

CREATE TABLE Transactions (
	transaction_id INT IDENTITY(1,1) PRIMARY KEY,
	category_id INT FOREIGN KEY REFERENCES Categories(category_id),
	amount DECIMAL(10, 2) NOT NULL,
	date DATE NOT NULL
);

-- 03_CREATE_INDEX

CREATE INDEX IX_Users_Username ON Users(username); 

CREATE INDEX IX_BankAccounts_UserId ON Bank_accounts(user_id);

CREATE INDEX IX_Categories_AccountId ON Categories(account_id);

CREATE INDEX IX_Categories_DetailType ON Categories(detail_type);

CREATE INDEX IX_Transactions_CategoryId ON Transactions(category_id);

CREATE INDEX IX_Transactions_Date ON Transactions(date);

CREATE INDEX IX_Transactions_CategoryDate ON Transactions(category_id, date);

