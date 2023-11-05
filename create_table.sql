CREATE TABLE ADDRESSES
(
	ID INT PRIMARY KEY,
	COUNTRY NVARCHAR(30) NOT NULL,
	STREET NVARCHAR(50) NOT NULL,
	CITY NVARCHAR(30) NOT NULL,
	NUM NVARCHAR(10) NOT NULL,
	ZIP_CODE NVARCHAR(10) NOT NULL
);

CREATE TABLE PHYSICIANS
(
	ID INT PRIMARY KEY,
	ADDRESS_ID INT NOT NULL,
	EDUCATION_LEVEL INT NOT NULL,
	FIRST_NAME NVARCHAR(30) NOT NULL,
	LAST_NAME NVARCHAR(30) NOT NULL,
	GENDER NVARCHAR(2) NOT NULL,
	DATE_OF_BIRTH DATE NOT NULL,
	PHONE_NUMBER NVARCHAR(30) NOT NULL,
	SALARY INT NOT NULL,
	FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESSES(ID)
);

CREATE TABLE PATIENTS
(
	ID INT PRIMARY KEY,
	ADDRESS_ID INT NOT NULL,
	FIRST_NAME NVARCHAR(30) NOT NULL,
	LAST_NAME NVARCHAR(30) NOT NULL,
	GENDER NVARCHAR(3) NOT NULL,
	DATE_OF_BIRTH DATE NOT NULL,
	PHONE_NUMBER NVARCHAR(30) NOT NULL,
	FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESSES(ID)
);

CREATE TABLE COMPANIES
(
	ID INT PRIMARY KEY,
	NAME NVARCHAR(50) NOT NULL
);

CREATE TABLE CATEGORIES
(
	ID INT PRIMARY KEY,
	NAME NVARCHAR(50) NOT NULL,
	DESCRIPTION NVARCHAR(200) NOT NULL
);

CREATE TABLE DRUGS
(
	ID INT PRIMARY KEY,
	COMPANY_ID INT NOT NULL,
	CATEGORY_ID INT NOT NULL,
	NAME NVARCHAR(50) NOT NULL,
	PRICE INT NOT NULL,
	DESCRIPTION NVARCHAR(200) NOT NULL,
	FOREIGN KEY(COMPANY_ID) REFERENCES COMPANIES(ID),
	FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORIES(ID)
);

CREATE TABLE PHARMACIES
(
	ID INT PRIMARY KEY,
	ADDRESS_ID INT NOT NULL,
	NAME NVARCHAR(50) NOT NULL,
	PHONE_NUMBER NVARCHAR(30) NOT NULL,
	FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESSES(ID)
);

CREATE TABLE PAYMENT_METHODS
(
	ID INT PRIMARY KEY,
	NAME NVARCHAR(50) NOT NULL
);

CREATE TABLE PRESCRIPTIONS
(
	ID INT PRIMARY KEY,
	PATIENT_ID INT NOT NULL,
	PHYSICIAN_ID INT NOT NULL,
	PHARMACY_ID INT NOT NULL,
	PAYMENT_METHOD_ID INT NOT NULL,
	CODE NVARCHAR(30) NOT NULL,
	TRANSACTION_DATE DATE NOT NULL,
	UNIQUE (CODE),
	FOREIGN KEY(PATIENT_ID) REFERENCES PATIENTS(ID),
	FOREIGN KEY(PHYSICIAN_ID) REFERENCES PHYSICIANS(ID),
	FOREIGN KEY(PHARMACY_ID) REFERENCES PHARMACIES(ID),
	FOREIGN KEY(PAYMENT_METHOD_ID) REFERENCES PAYMENT_METHODS(ID)
);

CREATE TABLE PRESCRIPTION_ITEMS
(
	PRESCRIPTION_ID INT NOT NULL,
	DRUG_ID INT NOT NULL,
	QUANTITY INT NOT NULL,
	FOREIGN KEY(PRESCRIPTION_ID) REFERENCES PRESCRIPTIONS(ID),
	FOREIGN KEY(DRUG_ID) REFERENCES DRUGS(ID),
	PRIMARY KEY(PRESCRIPTION_ID, DRUG_ID)
);

////////////////////////////////////////////////////////


ALTER TABLE patients
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE pharmacies
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE physicians
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE drugs
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE prescriptions
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE prescription_items
ADD UPDATED_AT DATETIME DEFAULT NOW();

ALTER TABLE payment_methods
ADD UPDATED_AT DATETIME DEFAULT NOW();


/////////////////////////////////////////////////////////

DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON patients
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

--------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON pharmacies
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

--------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON physicians
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

---------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON drugs
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

----------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON prescriptions
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

---------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON prescription_items
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;

---------------------------------------------
DELIMITER $$

CREATE TRIGGER set_timestamp_on_table_drugs
BEFORE UPDATE ON payment_methods
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;


//////////////////////////////////////////////////////////

DELIMITER $$

CREATE TRIGGER patients_updated_at_on_insert
BEFORE INSERT ON patients
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER drugs_updated_at_on_insert
BEFORE INSERT ON drugs
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER payment_methods_updated_at_on_insert
BEFORE INSERT ON payment_methods
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER pharmacies_updated_at_on_insert
BEFORE INSERT ON pharmacies
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER physicians_updated_at_on_insert
BEFORE INSERT ON physicians
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER prescription_items_updated_at_on_insert
BEFORE INSERT ON prescription_items
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;
--------------------------------------------

DELIMITER $$

CREATE TRIGGER prescriptions_updated_at_on_insert
BEFORE INSERT ON prescriptions
FOR EACH ROW
BEGIN
   SET NEW.UPDATED_AT = NOW();
END;

$$

DELIMITER ;