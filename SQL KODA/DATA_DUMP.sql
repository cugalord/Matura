--INSERT PRIMERI
INSERT INTO Member
VALUES ('BA065');

INSERT INTO Member
VALUES (SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5));

INSERT INTO Product
VALUES(SUBSTRING(UUID_TO_CHAR(GEN_UUID()) FROM 1 FOR 5),'Elan SLX','dolzina: 160cm',340,1,'BA065');


-- MEMBERJI
INSERT INTO Member
VALUES('05B1B');
INSERT INTO Member
VALUES('5F7DB');
INSERT INTO Member
VALUES('9260D');
INSERT INTO Member
VALUES('9CBBB');
INSERT INTO Member
VALUES('F47A9');
INSERT INTO Member
VALUES('73A41');
INSERT INTO Member
VALUES('380D1');
INSERT INTO Member
VALUES('23E8A');
INSERT INTO Member
VALUES('FC65F');
INSERT INTO Member
VALUES('1BCF7');
INSERT INTO Member
VALUES('F4824');
INSERT INTO Member
VALUES('591F2');
INSERT INTO Member
VALUES('54999');
INSERT INTO Member
VALUES('ACE16');
INSERT INTO Member
VALUES('1C549');
INSERT INTO Member
VALUES('DBDB2');
INSERT INTO Member
VALUES('E1F9D');
INSERT INTO Member
VALUES('F0030');
INSERT INTO Member
VALUES('893FB');
INSERT INTO Member
VALUES('5783A');


--PRODAJALCI
STAFFID S_NAME                                        S_SURNAME
======= ============================================= ==================================================
9C983   lenart                                        kos
239CD   bernard                                       kuchler
6F9B8   aljaz                                         dajcman
07121   jan                                           jenko

INSERT INTO Staff
VALUES('9C983','lenart','kos','lkoss');
INSERT INTO Staff
VALUES('239CD','bernard','kuchler','bk');
INSERT INTO Staff
VALUES('6F9B8','aljaz','dajcman','dici');
INSERT INTO Staff
VALUES('07121','jan','jenko','yenko');
INSERT INTO Staff
VALUES('07181','admin','admin','sysdba');

-- ptype-i
execute procedure input_ptype('smuci','',0.1,0.2);
execute procedure input_ptype('smucarski cevlji','',0.1,0.19);
execute procedure input_ptype('celada','',0.08,0.19);
execute procedure input_ptype('palice','',0.11,0.21);

PTYPEID T_NAME                                             T_DESCR                                                                                                                                                                                                     T_COMMISION            TAX
======= ================================================== =============================================================================== ============== ==============
0EC0C   smuci                                                                                                                                                                                                                                                           0.10000000     0.20000000
38641   smucarski cevlji                                                                                                                                                                                                                                                0.10000000     0.19000000
906BE   celada                                                                                                                                                                                                                                                         0.079999998     0.19000000
EB8EA   palice     

INSERT INTO Ptype
VALUES('0EC0C', 'smuci','', 0.11000000, 0.20999999);
INSERT INTO Ptype      
VALUES('38641', 'smucarski cevlji','', 0.10000000, 0.10000000);      
INSERT INTO Ptype      
VALUES('906BE', 'celada','', 0.079999998, 0.19000000); 
INSERT INTO ptype      
VALUES('EB8EA ', 'palice','', 0.11000000, 0.11000000);



--IZDELKI
execute procedure input_product('Atomic Revent +','',99.99,'906BE','05B1B');
execute procedure input_product('Alpina Grap Visor Blk Matt','',159.99,'906BE','5F7DB');
execute procedure input_product('Uvex Visor 400 Style','',149.99,'906BE','9260D');
execute procedure input_product('Atomic Revent Amid','',159.99,'906BE','9CBBB');

execute procedure input_product('Elan Amphibio 16 Ti EMX12.0','',555.99,'0EC0C','F47A9');
execute procedure input_product('Fischer RC4 WC SC Yelloq','',499.99,'0EC0C','73A41');
execute procedure input_product('Elan CARVE X','',159.99,'0EC0C','380D1');
execute procedure input_product('Head Supershape i. Speed','',639,99,'0EC0C','23E8A');

execute procedure input_product('Fischer RC4 Pro','',49.99,'EB8EA','5F7DB');
execute procedure input_product('Elan LiteRod','',49.99,'EB8EA','FC65F');
execute procedure input_product('Leki Elite Carbon','',69,99,'EB8EA','9260D');
execute procedure input_product('Kilimanjaro Plus ULTRALITE','',39,99,'EB8EA','F47A9');

execute procedure input_product('Salomon X PRO 120 V2','',279,99,'38641','73A41');
execute procedure input_product('Lange SX 120','',279,99,'38641','5F7DB');
execute procedure input_product('Fischer My Travers','',349,99,'38641','1BCF7');
execute procedure input_product('Salomon X PRO 90 W','',180,00,'38641','F4824');
execute procedure input_product('Atomic Revent +','',99.99,'906BE','05B1B');
execute procedure input_product('Alpina Grap Visor Blk Matt','',159.99,'906BE','5F7DB');
execute procedure input_product('Uvex Visor 400 Style','',149.99,'906BE','9260D');
execute procedure input_product('Atomic Revent Amid','',159.99,'906BE','9CBBB');

execute procedure input_product('Elan Amphibio 16 Ti EMX12.0','',555.99,'0EC0C','F47A9');
execute procedure input_product('Fischer RC4 WC SC Yelloq','',499.99,'0EC0C','73A41');
execute procedure input_product('Elan CARVE X','',159.99,'0EC0C','380D1');
execute procedure input_product('Head Supershape i. Speed','',639.99,'0EC0C','23E8A');

execute procedure input_product('Fischer RC4 Pro','',49.99,'EB8EA','5F7DB');
execute procedure input_product('Elan LiteRod','',49.99,'EB8EA','FC65F');
execute procedure input_product('Leki Elite Carbon','',69.99,'EB8EA','9260D');
execute procedure input_product('Kilimanjaro Plus ULTRALITE','',39.99,'EB8EA','F47A9');

execute procedure input_product('Salomon X PRO 120 V2','',279.99,'38641','73A41');
execute procedure input_product('Lange SX 120','',279.99,'38641','5F7DB');
execute procedure input_product('Fischer My Travers','',349.99,'38641','1BCF7');
execute procedure input_product('Salomon X PRO 90 W','',180.00,'38641','F4824');




PRODUCTID P_NAME                                             P_DESCR                                                                                                                                                                                                           PRICE PTYPEID P_OWNER
========= ================================================== =============================================================================== ============== ======= =======
5AAC0     Atomic Revent +                                                                                                                                                                                                                                                  99.989998 906BE   05B1B
ABF58     Alpina Grap Visor Blk Matt                                                                                                                                                                                                                                       159.99001 906BE   5F7DB
E4E82     Uvex Visor 400 Style                                                                                                                                                                                                                                             149.99001 906BE   9260D
00756     Atomic Revent Amid                                                                                                                                                                                                                                               159.99001 906BE   9CBBB
BE1CF     Elan Amphibio 16 Ti EMX12.0                                                                                                                                                                                                                                      555.98999 0EC0C   F47A9
0B5AD     Fischer RC4 WC SC Yelloq                                                                                                                                                                                                                                         499.98999 0EC0C   73A41
94039     Elan CARVE X                                                                                                                                                                                                                                                     159.99001 0EC0C   380D1
6137E     Head Supershape i. Speed                                                                                                                                                                                                                                         639.98999 0EC0C   23E8A
221F1     Fischer RC4 Pro                                                                                                                                                                                                                                                  49.990002 EB8EA   5F7DB
1A161     Elan LiteRod                                                                                                                                                                                                                                                     49.990002 EB8EA   FC65F
B663A     Leki Elite Carbon                                                                                                                                                                                                                                                69.989998 EB8EA   9260D
A9FA6     Kilimanjaro Plus ULTRALITE                                                                                                                                                                                                                                       39.990002 EB8EA   F47A9
9DB9F     Salomon X PRO 120 V2                                                                                                                                                                                                                                             279.98999 38641   73A41
1DA97     Lange SX 120                                                                                                                                                                                                                                                     279.98999 38641   5F7DB
F63DB     Fischer My Travers                                                                                                                                                                                                                                               349.98999 38641   1BCF7
09BA7     Salomon X PRO 90 W                                                                                                                                                                                                                                               180.00000 38641   F4824



INSERT INTO Product
VALUES('5AAC0','Atomic Revent +','',100,'906BE','05B1B');
INSERT INTO Product
VALUES('ABF58','Alpina Grap Visor Blk Matt','',159.99,'906BE','5F7DB');
INSERT INTO Product
VALUES('E4E82','Uvex Visor 400 Style','',149.99,'906BE','9260D');
INSERT INTO Product
VALUES('00756','Atomic Revent Amid','',159.99,'906BE','9CBBB');
INSERT INTO Product
VALUES('BE1CF','Elan Amphibio 16 Ti EMX12.0','',555.98999,'0EC0C','F47A9');
INSERT INTO Product
VALUES('0B5AD','Fischer RC4 WC SC Yelloq','',499.99,'0EC0C','73A41');
INSERT INTO Product
VALUES('94039','Elan CARVE X','',159.99,'0EC0C','380D1');
INSERT INTO Product
VALUES('6137E','Head Supershape i. Speed','',639.99,'0EC0C','23E8A');
INSERT INTO Product
VALUES('221F1','Fischer RC4 Pro','',49.99,'EB8EA','5F7DB');
INSERT INTO Product
VALUES('1A161','Elan LiteRod','',49.99,'EB8EA','FC65F');
INSERT INTO Product
VALUES('B663A','Leki Elite Carbon','',69.99,'EB8EA','9260D');
INSERT INTO Product
VALUES('A9FA6','Kilimanjaro Plus ULTRALITE','',39.99,'EB8EA','F47A9');
INSERT INTO Product
VALUES('9DB9F','Salomon X PRO 120 V2','',279.99,'38641','73A41');
INSERT INTO Product
VALUES('1DA97','Lange SX 120','',279.99,'38641','5F7DB');
INSERT INTO Product
VALUES('F63DB','Fischer My Travers','',349.99,'38641','1BCF7');
INSERT INTO Product
VALUES('09BA7','Salomon X PRO 90 W','',180.00,'38641','F4824');

--EVENTI
execute procedure input_event(2,'9C983','591F2','9DB9F');
execute procedure input_event(3,'239CD','54999','1DA97');
execute procedure input_event(2,'6F9B8','ACE16','F63DB');
execute procedure input_event(3,'239CD','1C549','09BA7');
execute procedure input_event(2,'9C983','DBDB2','5AAC0');
execute procedure input_event(3,'6F9B8','E1F9D','ABF58');
execute procedure input_event(2,'9C983','F0030','E4E82');
execute procedure input_event(3,'239CD','893FB','00756');
execute procedure input_event(2,'6F9B8','5783A','BE1CF');
execute procedure input_event(3,'07121','05B1B','0B5AD');
execute procedure input_event(2,'6F9B8','5F7DB','94039');
execute procedure input_event(3,'07121','9260D','6137E');
execute procedure input_event(2,'6F9B8','9CBBB','221F1');
execute procedure input_event(3,'07121','F47A9','1A161');
execute procedure input_event(2,'9C983','73A41','B663A');
execute procedure input_event(3,'9C983','380D1','A9FA6');
execute procedure input_event(4,'239CD','54999','1DA97');
execute procedure input_event(4,'239CD','1C549','09BA7');
execute procedure input_event(4,'6F9B8','E1F9D','ABF58');
execute procedure input_event(4,'239CD','893FB','00756');
execute procedure input_event(4,'07121','05B1B','0B5AD');
execute procedure input_event(4,'07121','9260D','6137E');
execute procedure input_event(4,'07121','F47A9','1A161');
execute procedure input_event(4,'9C983','380D1','A9FA6');

EVENTID    EVENTTYPE                TIME_STAMP STAFFID MEMBERID PRODUCTID P_OWNER
======= ============ ========================= ======= ======== ========= =======
22616              2 2020-01-25 22:10:58.2060  9C983   591F2    9DB9F     73A41
13D36              3 2020-01-25 22:10:58.2080  239CD   54999    1DA97     5F7DB
235B5              2 2020-01-25 22:10:58.2090  6F9B8   ACE16    F63DB     1BCF7
A408D              3 2020-01-25 22:10:58.2120  239CD   1C549    09BA7     F4824
23FC0              2 2020-01-25 22:10:58.2140  9C983   DBDB2    5AAC0     05B1B
E8B24              3 2020-01-25 22:10:58.2170  6F9B8   E1F9D    ABF58     5F7DB
38F7E              2 2020-01-25 22:10:58.2200  9C983   F0030    E4E82     9260D
9C114              3 2020-01-25 22:10:58.2220  239CD   893FB    00756     9CBBB
F26AE              2 2020-01-25 22:10:58.2240  6F9B8   5783A    BE1CF     F47A9
73B65              3 2020-01-25 22:10:58.2270  07121   05B1B    0B5AD     73A41
8DD1A              2 2020-01-25 22:10:58.2290  6F9B8   5F7DB    94039     380D1
48B3F              3 2020-01-25 22:10:58.2310  07121   9260D    6137E     23E8A
06CDE              2 2020-01-25 22:10:58.2330  6F9B8   9CBBB    221F1     5F7DB
04E77              3 2020-01-25 22:10:58.2360  07121   F47A9    1A161     FC65F
1B26E              2 2020-01-25 22:10:58.2380  9C983   73A41    B663A     9260D
3A1B5              3 2020-01-25 22:10:59.3330  9C983   380D1    A9FA6     F47A9



-- test klic za trigger
execute procedure input_product('TEST ZA TRIGGER','',1000,'38641','73A41');
