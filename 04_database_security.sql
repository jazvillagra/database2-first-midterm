-- 10)Cree un usuario para usted (nombre_apellido) y asígnele por defecto el
-- tablespace creado, así como el rol para conectarse.
CREATE USER jazmin_villagra
IDENTIFIED BY jvillagra
DEFAULT TABLESPACE BASEDATOS2
TEMPORARY TABLESPACE tmp;

GRANT CREATE SESSION TO jazmin_villagra;

CREATE USER matias_fare
IDENTIFIED BY mfare
DEFAULT TABLESPACE BASEDATOS2
TEMPORARY TABLESPACE tmp;

GRANT CREATE SESSION TO matias_fare;

CREATE USER yesshua_lopez
IDENTIFIED BY ylopez
DEFAULT TABLESPACE BASEDATOS2
TEMPORARY TABLESPACE tmp;

GRANT CREATE SESSION TO yesshua_lopez;

COMMIT;
-- 11)Cree un script para grantear al usuario creado los privilegios de:
-- * SELECT sobre las tablas de los todos los módulos.
-- * INSERT, UPDATE, DELETE sobre las tablas que pertenecen a los módulos
-- de Solidaridad (SOL) y Créditos (CRE).

set pagesize 80;
set linesize 180;
column TABLE_NAME format A20; 
SET HEADING OFF  FEEDBACK OFF ECHO OFF UNDERLINE OFF;

SELECT 'GRANT CREATE SESSION ON ' || TABLE_NAME || ' TO jazmin_villagra, matias_fare, yesshua_lopez;'
FROM tabs;

spool /opt/oracle/oradata/grant-select-all.sql
/
spool off

COMMIT;

set pagesize 80;
set linesize 180;

SELECT 'GRANT INSERT, UPDATE, DELETE ON ' || TABLE_NAME || ' TO jazmin_villagra, matias_fare, yesshua_lopez;'
FROM tabs WHERE TABLE_NAME LIKE '%CRE%' OR TABLE_NAME LIKE '%SOL%';


spool /opt/oracle/oradata/grant.sql
/
spool off

COMMIT;