-- -----------------------------------------------------
-- DOMAINS
-- 1 Vnos izdelka v tab. product
-- 2 Rezervacija izdelka
-- 3 Plačilo izdelka
-- 4 Predaja izdelka kupcu
-- -----------------------------------------------------
CREATE DOMAIN ET AS
INT CHECK (VALUE IN (1,2,3,4));
--------------------------------------------------------
--------------------------------------------------------

-- -----------------------------------------------------
-- Table Member
-- -----------------------------------------------------
CREATE TABLE Member(
  MemberID VARCHAR(5),
  PRIMARY KEY (MemberID),
  CONSTRAINT M_id CHECK (CHAR_LENGTH(MemberID)=5)
);
-- -----------------------------------------------------
-- Table Ptype
-- -----------------------------------------------------
CREATE TABLE Ptype(
  PtypeID VARCHAR(5) NOT NULL,
  T_name VARCHAR(50) NOT NULL,
  T_Descr VARCHAR(200) NOT NULL,
  T_Commision FLOAT NOT NULL,
  Tax float NOT NULL,
  PRIMARY KEY (PtypeID),
  CONSTRAINT Comm_valchk CHECK (T_Commision BETWEEN 0 AND 1),
  CONSTRAINT Tax_valchk CHECK (Tax BETWEEN 0 AND 1),
  CONSTRAINT T_id CHECK (CHAR_LENGTH(PtypeID)=5)
);
-- -----------------------------------------------------
-- Table Staff
-- -----------------------------------------------------
CREATE TABLE Staff(
  StaffID VARCHAR(5) NOT NULL,
  S_Name VARCHAR(45) NOT NULL,
  S_Surname VARCHAR(50) NOT NULL,
  S_Username CHAR(31) NOT NULL,
  PRIMARY KEY (StaffID),
  CONSTRAINT S_id CHECK (CHAR_LENGTH(StaffID)=5)
);
-- -----------------------------------------------------
-- Table Product
-- -----------------------------------------------------
CREATE TABLE Product(
  ProductID VARCHAR(5),
  P_Name VARCHAR(50) NOT NULL,
  P_Descr VARCHAR(200),
  Price FLOAT NOT NULL,
  PtypeID VARCHAR(5) NOT NULL,
  P_Owner VARCHAR(5) NOT NULL,
  PRIMARY KEY (ProductID, P_Owner),
  CONSTRAINT fk_Ptype
    FOREIGN KEY (PtypeID) REFERENCES Ptype(PtypeID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Member
    FOREIGN KEY (P_Owner) REFERENCES Member(MemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT P_id CHECK (CHAR_LENGTH(ProductID)=5),
  CONSTRAINT O_id CHECK (CHAR_LENGTH(P_Owner)=5),
  CONSTRAINT T_idd CHECK (CHAR_LENGTH(PtypeID)=5)
);
-- -----------------------------------------------------
-- Table Event
-- -----------------------------------------------------
CREATE TABLE Event(
  EventID VARCHAR(5) NOT NULL,
  EventType ET NOT NULL,
  Time_stamp TIMESTAMP NOT NULL,
  StaffID VARCHAR(5) NOT NULL,
  MemberID VARCHAR(5) NOT NULL,
  ProductID VARCHAR(5) NOT NULL,
  P_Owner VARCHAR(5) NOT NULL,
  PRIMARY KEY (EventID, StaffID, MemberID, ProductID, P_Owner),
  CONSTRAINT fk_Staff
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Member2
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product
    FOREIGN KEY (ProductID, P_Owner) REFERENCES Product(ProductID, P_Owner)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT M_idd CHECK (CHAR_LENGTH(MemberID)=5),
  CONSTRAINT P_idd CHECK (CHAR_LENGTH(ProductID)=5),
  CONSTRAINT O_idd CHECK (CHAR_LENGTH(P_Owner)=5),
  CONSTRAINT S_idd CHECK (CHAR_LENGTH(StaffID)=5)
);