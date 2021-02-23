:loop
cd C:\Program Files\Firebird\Firebird_3_0
isql -user sysdba -password masterkey "localhost:c:\baze\sejemv2.fdb" -i "C:\Program Files\Firebird\Firebird_3_0\skripta.sql"
timeout /t 30
goto loop