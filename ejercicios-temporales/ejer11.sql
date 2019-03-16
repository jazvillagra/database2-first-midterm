spool /opt/oracle/oradata/grant.sql

SELECT 'GRANT INSERT, UPDATE, DELETE ON '|| TABLE_NAME ||' TO jazmin_villagra'
FROM tabs
WHERE TABLE_NAME LIKE '%CRE%';

spool off
