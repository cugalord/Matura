----------------------EXCEPTIONS-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------EXCEPTIONS-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------EXCEPTIONS-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------EXCEPTIONS-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------EXCEPTIONS-------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE EXCEPTION EVENT_BUSY 'Already reserved';

----------------------PROCEDURES-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------PROCEDURES-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------PROCEDURES-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------PROCEDURES-------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------PROCEDURES-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SHOW_BASKET PROCEDURA
SET TERM !! ;
CREATE PROCEDURE show_basket(mID VARCHAR(5))
RETURNS(id VARCHAR(5), ime VARCHAR(50), cena float, provizija float, davek float, cas int) AS
BEGIN
  :mID=UPPER(:mID);
--SELECT ZA ISKANJE izdelkov lastnika ki so bili ze placani
  FOR 
    SELECT p.productID, p.P_Name, p.Price*(-1)+(p.Price*pt.T_commision), pt.T_commision, pt.tax
    FROM Member m
    INNER JOIN Product p
    ON p.P_Owner=m.memberID
    INNER JOIN Event e
    ON p.productID=e.productID
    INNER JOIN Ptype pt
    ON p.PtypeID=pt.ptypeID
    WHERE p.P_Owner=:mID AND e.eventtype=3 AND p.productID NOT IN(
      SELECT p.productID
      FROM Member m
      INNER JOIN Product p
      ON p.P_Owner=m.memberID
      INNER JOIN Event e
      ON p.productID=e.productID
      WHERE p.P_Owner=:mID AND e.memberID=:mID AND e.eventtype=3
    )
  INTO :id, :ime, :cena, :provizija, :davek
  DO BEGIN
    SUSPEND;
  END
--SELECT ZA ISKANJE izdelkov kupca ki so rezervirani 
  FOR
    SELECT p.productID, p.P_Name, p.Price, pt.T_commision, pt.tax, datediff(minute from e.time_stamp to CURRENT_TIMESTAMP)
    FROM Member m
    INNER JOIN Event e
    ON e.memberID=m.memberID
    INNER JOIN Product p
    ON e.productID=p.productID
    INNER JOIN Ptype pt
    ON p.PtypeID=pt.ptypeID
    WHERE e.memberID=:mID AND e.eventtype=2 AND p.productID NOT IN(
      SELECT p.productID
      FROM Member m
      INNER JOIN Event e
      ON e.memberID=m.memberID
      INNER JOIN Product p
      ON e.productID=p.productID
      WHERE e.memberID=:mID AND e.eventtype=3
    )
  INTO :id, :ime, :cena, :provizija, :davek, :cas
  DO BEGIN
    SUSPEND;
  END
--SELECT ZA ISKANJE izdelkov lastnika ki jih hoce prevzeti nazaj v svojo last
  FOR 
    SELECT p.productID, p.P_Name, p.Price*(0)
    FROM Member m
    INNER JOIN Product p
    ON p.P_Owner=m.memberID
    INNER JOIN Event e
    ON p.productID=e.productID
    INNER JOIN Ptype pt
    ON p.PtypeID=pt.ptypeID
    WHERE p.P_Owner=:mID AND e.memberID=:mID AND e.eventtype=2 AND p.productID NOT IN(
      SELECT p.productID
      FROM Member m
      INNER JOIN Event e
      ON e.memberID=m.memberID
      INNER JOIN Product p
      ON e.productID=p.productID
      WHERE e.memberID=:mID AND e.eventtype=3
    )
  INTO :id, :ime, :cena
  DO BEGIN
    SUSPEND;
  END
END!!
SET TERM ; !!
------------------------------------------------------------------------------------------

--GEN_MEM PROCEDURA
SET TERM !! ;
CREATE PROCEDURE gen_mem (x int) RETURNS (Izpis char(50)) AS
DECLARE VARIABLE stevec int;
BEGIN
  :stevec = 1;
  :Izpis='Dodajanje uspesno';
  --V ZANKI INSERTAMO ZA INPUT MEMBERJEV
  WHILE (:stevec <= :x ) DO 
  BEGIN
      INSERT INTO Member
      VALUES (SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5));
    :stevec=:stevec + 1;
  END
  WHEN ANY DO BEGIN
    :Izpis = 'Dodajanje neuspesno';
  END   
END !!
set TERM ; !!
------------------------------------------------------------------------------------------

--INPUT_PRODUCT PROCEDURA
SET TERM !! ;
CREATE PROCEDURE input_product (ime VARCHAR(50), opis VARCHAR(200), cena float, tip VARCHAR(5), lastnik VARCHAR(5)) RETURNS (Izpis char(50)) AS
BEGIN
  :tip=UPPER(:tip);
  :lastnik=UPPER(:lastnik);

  :Izpis='Dodajanje uspesno';
  BEGIN
      INSERT INTO Product
      VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5), :ime, :opis, :cena, :tip, :lastnik);
  END
  WHEN ANY DO BEGIN
    :Izpis = 'Dodajanje neuspesno';
  END   
END !!
set TERM ; !!
------------------------------------------------------------------------------------------

--INPUT_STAFF PROCEDURA
SET TERM !! ;
CREATE PROCEDURE input_staff (ime VARCHAR(45), priimek VARCHAR(50), username varchar(50)) RETURNS (Izpis char(50)) AS
BEGIN
  :Izpis='Dodajanje uspesno';
  BEGIN
    INSERT INTO Staff
    VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5), :ime, :priimek, :username);
  END
  WHEN ANY DO BEGIN
    :Izpis = 'Dodajanje neuspesno';
  END   
END !!
set TERM ; !!
------------------------------------------------------------------------------------------

--INPUT_Ptype PROCEDURA
SET TERM !! ;
CREATE PROCEDURE INPUT_Ptype (ime VARCHAR(45), opis VARCHAR(200), provizija FLOAT, davek FLOAT) RETURNS (Izpis char(50)) AS
BEGIN
  :Izpis = 'Dodajanje uspesno';
  BEGIN
    INSERT INTO Ptype
    VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5), :ime, :opis, :provizija, :davek);
  END
  WHEN ANY DO BEGIN --ERROR HANDLE
    :Izpis = 'Dodajanje neuspesno';
  END   
END !!
set TERM ; !!
------------------------------------------------------------------------------------------

--MEM_OUT PROCEDURA
SET TERM !! ;
CREATE PROCEDURE MEM_OUT (x int) 
RETURNS (id VARCHAR(5)) AS
BEGIN
  BEGIN
    FOR
      SELECT SKIP ((SELECT COUNT(*) - (:x) FROM Member)) Memberid
      FROM Member m
      INTO :id
    DO BEGIN
      SUSPEND;
    END
  END
END !!
set TERM ; !!
------------------------------------------------------------------------------------------

--INPUT_EVENT PROCEDURA
SET TERM !! ;
CREATE OR ALTER PROCEDURE input_EVENT (tip int, staff VARCHAR(5), kupec VARCHAR(5), izdelek VARCHAR(5)) RETURNS (Izpis char(50)) AS
DECLARE VARIABLE lastnik VARCHAR(5);
DECLARE VARIABLE cas TIMESTAMP;
DECLARE VARIABLE cash_kupec VARCHAR(5);
BEGIN
  :staff=UPPER(:staff);
  :kupec=UPPER(:kupec);
  :izdelek=UPPER(:izdelek);

--SELECT ZA ISKANJE lastnika izdelka na podlagi id izdelka 
  FOR 
    SELECT p.P_Owner
    FROM Product p
    WHERE p.productID=:izdelek
  INTO :lastnik 
  DO BEGIN
  END

  IF(:tip=4) THEN
  BEGIN
    --SELECT ZA ISKANJE kupca pri prodaji izdelka na podlagi id izdelka 
    FOR 
      SELECT e.memberID
      FROM Event e
      INNER JOIN Product p
      ON p.productID=e.productID
      WHERE e.productID=:izdelek AND e.eventtype=3 AND e.memberID!=p.P_Owner
    INTO :cash_kupec 
    DO BEGIN
    END
  END

    :Izpis = 'Dodajanje neuspesno';
IF ((:tip=1 AND :kupec = :lastnik) OR (:tip=4 AND :kupec = :cash_kupec) OR :tip=2 OR :tip=3) THEN
    BEGIN
      --INSERT V TABELO EVENT  
        INSERT INTO Event
        VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5), :tip, CURRENT_TIMESTAMP, :staff, :kupec, :izdelek , :lastnik);
      --CE LASTNIK IZDELEK PREVZAME NAZAJ SETAMO CENO Izdelka na 0
      IF(:tip=3 AND :lastnik=:kupec) THEN
        BEGIN
          UPDATE Product
          SET Price=0
          WHERE productid=:izdelek;
      END
      :Izpis='Dodajanje uspesno';
    END

END !!
set TERM ; !!
------------------------------------------------------------------------------------------
--CASH FLOW VIEW PROCEDURI

--CASH_SUM IZRACUNA SUM, CASH_LOG PRIKAZE VSE DENARNE TRANSAKCIJE EVENT(3)
--CASH LOG
SET TERM !! ;
CREATE PROCEDURE cash_log
RETURNS(eventID varchar(5), izdelekID VARCHAR(5), imeS varchar(45), priimekS varchar(45), ime_izdelka varchar(50),cena_izdelka FLOAT, provizija_izdelka FLOAT, davek_izdelka FLOAT) AS
BEGIN
    --SELECT ZA ISKANJE vseh denarnih transakcij
    FOR 
      SELECT e.eventID, p.productID, p.P_name, p.price, pt.T_commision, pt.tax, s.S_name, s.S_surname
      FROM Event e
      INNER JOIN Staff s
      ON s.staffID=e.staffID
      INNER JOIN Product p
      ON p.productID=e.productID
      INNER JOIN Ptype pt
      ON p.PtypeID=pt.ptypeID
      WHERE e.eventtype=3
      ORDER BY e.time_stamp
    INTO :eventID, :izdelekID, :ime_izdelka, :cena_izdelka, :provizija_izdelka, :davek_izdelka, :imeS, :priimekS
    DO BEGIN
      SUSPEND;
    END
END!!
SET TERM ; !!

--CASH SUM
SET TERM !! ;
CREATE PROCEDURE cash_sum
RETURNS(skupno FLOAT, profit FLOAT, davek FLOAT) AS
DECLARE VARIABLE sum_davek float;
DECLARE VARIABLE sum_provizija float;
DECLARE VARIABLE sum_skupaj float;
BEGIN
-- Nastavimo spremenljivke
  :skupno=0;
  :profit=0;
  :davek=0;
    --SELECT ZA SUM promet,DAVEK IN PROVIZIJO
    FOR 
      SELECT p.price,((p.price-(p.price*pt.tax))*pt.T_commision), (p.price*pt.tax)
      FROM Event e
      INNER JOIN Product p
      ON p.productID=e.productID
      INNER JOIN Ptype pt
      ON pt.ptypeID=p.PtypeID
      WHERE e.eventtype=3
    INTO :sum_skupaj, :sum_provizija, :sum_davek
    DO BEGIN
    --SESTEVAMO VREDNOSTI ZA SUM
      :skupno=:skupno+:sum_skupaj;
      :profit=:profit+:sum_provizija;
      :davek=:davek+:sum_davek;
    END
  SUSPEND;
END!!
SET TERM ; !!
------------------------------------------------------------------------------------------
--PERSON & PRODUCT FLOW
SET TERM !! ;
CREATE PROCEDURE pp_flow
RETURNS(person int, product int) AS
BEGIN
    --SELECT  ALL PERSON
    FOR 
      SELECT DISTINCT COUNT(e.memberID)
      FROM Member M
      INNER JOIN Event e
      ON m.memberID=e.memberID
    INTO :person
    DO BEGIN
    END
    --SELECT  ALL PRODUCT
    FOR 
      SELECT DISTINCT COUNT(productID)
      FROM Product
    INTO :product
    DO BEGIN
    END
  SUSPEND;
END!!
SET TERM ; !!
------------------------------------------------------------------------------------------

--Out_flow 
SET TERM !! ;
CREATE PROCEDURE Out_flow(mID varchar(5))
RETURNS(id VARCHAR(5), ime VARCHAR(50)) AS
DECLARE VARIABLE tmp VARCHAR(5);
DECLARE VARIABLE zmp VARCHAR(5);
DECLARE VARIABLE flag int;
BEGIN
  :mID=UPPER(:mID);
  :flag=0;

  FOR 
    SELECT e.productid
    FROM Event e
    INNER JOIN Product p
    ON p.productID=e.productID
    WHERE e.eventtype=3 AND e.memberID=:mid AND p.P_Owner!=:mid
  INTO :tmp
  DO BEGIN
    FOR
      SELECT e.productID
      FROM Event e
      WHERE e.eventtype=4 AND e.productID=:tmp
      INTO :zmp
      DO BEGIN
        :flag=1;
      END

    IF(:flag=0) THEN BEGIN
      FOR 
      SELECT p.productid,p.P_Name
      FROM Product p
      WHERE p.productid=:tmp
      INTO :id, :ime
      DO BEGIN
        SUSPEND;
      END
    END
  END
END!!
SET TERM ; !!
-----------------------------------------------------------------------------------------

--staff_login
SET TERM !! ;
CREATE PROCEDURE staff_login(username varchar(50))
RETURNS(id VARCHAR(5), ime VARCHAR(45), priimek VARCHAR(50)) AS
BEGIN
    --GET ID FROM UNAME
    FOR 
      SELECT staffID,s_name,S_surname
      From Staff
      WHERE S_username=:username
    INTO :id, :ime, :priimek
    DO BEGIN
      SUSPEND;
    END
END!!
SET TERM ; !!
-----------------------------------------------------------------------------------------

--Ptype_out
SET TERM !! ;
CREATE PROCEDURE Ptype_out
RETURNS(id VARCHAR(5), ime VARCHAR(50)) AS
BEGIN
    FOR
    SELECT PtypeID,T_Name
    FROM Ptype
    INTO :id, :ime
    DO BEGIN
      SUSPEND;
    END
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------

--find_staff
SET TERM !! ;
CREATE PROCEDURE Find_staff
RETURNS (id VARCHAR(5)) AS
DECLARE VARIABLE uname char(31);
BEGIN
--dobimo username
  FOR
  SELECT FIRST 1 sec$user_name
  FROM  SEC$USERS
  WHERE sec$user_name=CURRENT_USER
  INTO :uname
  DO BEGIN
  END

--dobimo id
  FOR
  SELECT FIRST 1 StaffID
  FROM Staff
  WHERE UPPER(SUBSTRING(S_username FROM 1 FOR 30))=:uname OR SUBSTRING(S_username FROM 1 FOR 30)=:uname
  INTO :id
  DO BEGIN
    SUSPEND;
  END
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------

--find_product
SET TERM !! ;
CREATE PROCEDURE Find_product(id VARCHAR(5))
RETURNS (IID VARCHAR(5), Pname VARCHAR(50), OWNER VARCHAR(5), price float) AS
BEGIN

  FOR
  SELECT ProductID, P_Name, P_Owner, Price 
  FROM Product
  WHERE ProductID=:id
  INTO :IID, :Pname, :OWNER, :price
  DO BEGIN
    SUSPEND;
  END

END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------

--I_Staff
SET TERM !! ;
CREATE PROCEDURE I_Staff(Ime varchar(45), Priimek varchar(45), S_username char(31))
RETURNS (Izpis VARCHAR(100)) AS
DECLARE VARIABLE uname char(31);
BEGIN
  :Izpis='Dodajanje uspesno';
  BEGIN
      INSERT INTO Staff
      VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5), :Ime, :Priimek, :S_username);
  END
  WHEN ANY DO BEGIN
    :Izpis = 'Dodajanje neuspesno';
  END   
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------

--Purge_reservation
SET TERM !! ;
CREATE PROCEDURE Purge_reservation
BEGIN
DELETE FROM Event WHERE datediff(minute from time_stamp to CURRENT_TIMESTAMP) > 15;
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--test klici
execute procedure gen_mem(2);
execute procedure input_staff('Nejc','Vrčon Zupan','sysdba');
execute procedure input_ptype('smuci','lolololol',0.1,0.2);
execute procedure input_product('elan slx 160cm','dolzina 160 cm neki neki',120,'0B82A','E22D8');
execute procedure input_event(2,'EE265','54580','06233');
SELECT * FROM show_basket();
SELECT * FROM cash_log;
SELECT * FROM cash_sum;
SELECT * FROM pp_flow;
SELECT * FROM Out_flow();
SELECT * FROM staff_login();
SELECT * FROM Ptype_out;



----------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------------------------------------------
SET TERM !! ;
CREATE TRIGGER IP_log FOR Product
AFTER INSERT
AS
DECLARE VARIABLE uporabnik_id VARCHAR(5);
DECLARE VARIABLE Izpis CHAR(50);
BEGIN
 --NAJDEMO STAFF_ID
  FOR
    SELECT *
    FROM Find_staff
    INTO :uporabnik_id
    DO BEGIN
  END

  --NAREDIMO LOG Z INPUT_EVENT
  EXECUTE PROCEDURE INPUT_EVENT(1,:uporabnik_id,New.P_Owner,New.ProductID) RETURNING_VALUES(:Izpis);
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

SET TERM !! ;
CREATE TRIGGER E_chk FOR Event
BEFORE INSERT AS
DECLARE VARIABLE flag int;
DECLARE VARIABLE tmp VARCHAR(5);
DECLARE VARIABLE lastnik VARCHAR(5);
BEGIN
--DOBIMO ID LASTNIKA
  FOR
    SELECT P_Owner
    FROM Product
    WHERE productID=new.productID
  INTO :lastnik
  DO BEGIN
  END

--ET 3 SE ZGODI DVAKRAT (KUPEC KUPI, LASTNIK DOBI)
  IF(new.eventtype=3) THEN
  BEGIN
    FOR
      SELECT memberID
      FROM Event
      WHERE eventtype=new.eventtype AND productID=new.productID
    INTO :tmp
    DO BEGIN
      IF(:tmp is not null) THEN
      BEGIN
        IF(new.memberid=:lastnik) THEN
        BEGIN
          IF(:tmp=:lastnik) THEN
          BEGIN
            EXCEPTION EVENT_BUSY;
          END
        END
      END
    END 
  END

--ET 2 SE NE MORE ZGODITI CE JE NAREJEN ZE ET=3
  ELSE IF(new.eventtype=2) THEN
  BEGIN
    FOR
      SELECT memberID
      FROM Event
      WHERE eventtype IN(2,3) AND productID=new.productID
    INTO :tmp
    DO BEGIN
      IF(:tmp is not null) THEN BEGIN
        EXCEPTION EVENT_BUSY;
      END
    END
  END

  ELSE BEGIN
    FOR
    SELECT eventid
    FROM Event
    WHERE eventtype=new.eventtype AND productID=new.productID
    INTO :tmp
    DO BEGIN
      IF(tmp is not null) THEN
      BEGIN
        EXCEPTION EVENT_BUSY;
      END
    END
  END
END!!
SET TERM ; !!
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
