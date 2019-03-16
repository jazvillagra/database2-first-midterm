--alter session if necessary
ALTER SESSION set "_ORACLE_SCRIPT"=true;

--create user BASEDATOS with password BASEDATOS
CREATE USER BASEDATOS IDENTIFIED BY BASEDATOS DEFAULT TABLESPACE TPBD2 TEMPORARY TABLESPACE TEMP;  
GRANT DBA TO BASEDATOS WITH ADMIN OPTION;