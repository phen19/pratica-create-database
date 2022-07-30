CREATE DATABASE "Drivenbank";

--Tabela customers
CREATE TABLE customers (
	id SERIAL NOT NULL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);
-- Criando ENUM type
CREATE TYPE type AS ENUM('landline','mobile');

-- Tabela customersPhones
CREATE TABLE customersPhones (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	number TEXT NOT NULL,
	type TYPE NOT NULL
);

-- Tabela states
CREATE TABLE states (
	id SERIAL NOT NULL PRIMARY KEY,
	name TEXT NOT NULL
);

-- Tabela cities
CREATE TABLE cities (
	id SERIAL NOT NULL PRIMARY KEY,
	name TEXT NOT NULL,
	"stateId" INTEGER REFERENCES states(id)
);

-- Tabela customerAddresses
CREATE TABLE customerAddresses (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	street TEXT NOT NULL,
	number INTEGER NOT NULL,
	complement TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER REFERENCES cities(id)
);

-- Tabela bankAccount
CREATE TABLE bankAccount (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"accountNumber" TEXT NOT NULL UNIQUE,
	agency TEXT NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE
);

-- Criando ENUM typeTransactions
CREATE TYPE "typeTransactions" AS ENUM('deposit','withdraw');

-- Tabela transactions
CREATE TABLE transactions (
	id SERIAL NOT NULL PRIMARY KEY,
	"banckAccountId" INTEGER REFERENCES bankAccount(id),
	amount INTEGER NOT NULL,
	type "typeTransactions" NOT NULL,
	time TIMESTAMP NOT NULL,
	description TEXT,
	cancelled BOOLEAN NOT NULL
);

-- Tabela CreditCards
CREATE TABLE "creditCards" (
	id SERIAL NOT NULL PRIMARY KEY,
	"banckAccountId" INTEGER REFERENCES bankAccount(id),
	name TEXT NOT NULL,
	number TEXT NOT NULL,
	"securityCode" INTEGER NOT NULL,
	"expirationMonth" INT NOT NULL,
	"expirationYear" INT NOT NULL,
	password TEXT NOT NULL,	
	"limit" INTEGER NOT NULL
);