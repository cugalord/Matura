-- SHOW_BASKET PROCEDURA
SET TERM !! ;
CREATE PROCEDURE show_basket(mID VARCHAR(5))
RETURNS(id VARCHAR(5), ime VARCHAR(50), cena float, provizija float, davek float, cas int) AS
DECLARE VARIABLE chki varchar(5);
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
   :chki=:id;
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
  IF(:chki != :id) THEN BEGIN
    SUSPEND;
  END
  END
  END
END!!
SET TERM ; !!