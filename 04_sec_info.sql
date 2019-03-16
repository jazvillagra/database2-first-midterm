-- 10)Cree un usuario para usted (nombre_apellido) y asígnele por defecto el
-- tablespace creado, así como el rol para conectarse.
CREATE USER jazmin_villagra IDENTIFIED BY jvillagra DEFAULT TABLESPACE BASEDATOS2; 
GRANT CONNECT TO jazmin_villagra;
COMMIT;
-- 11)Cree un script para grantear al usuario creado los privilegios de:
-- * SELECT sobre las tablas de los todos los módulos.
-- * INSERT, UPDATE, DELETE sobre las tablas que pertenecen a los módulos
-- de Solidaridad (SOL) y Créditos (CRE).
spool /opt/oracle/oradata/grant.sql

SELECT 'GRANT INSERT, UPDATE, DELETE ON '|| TABLE_NAME ||' TO jazmin_villagra'
FROM tabs
WHERE TABLE_NAME LIKE '%CRE%';

spool off

COMMIT;