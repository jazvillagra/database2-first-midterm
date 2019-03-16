-- 1) Cree la secuencia SEQ_SOCIO iniciando en 1 y con incrementos de 1
CREATE SEQUENCE seq_socio START WITH 1 INCREMENT BY 1;
COMMIT;
--2) Inserte datos en la tabla soc_socio a partir de la tabla b_personas
-- fisicas de su esquema de lal clase (el id del socio sera asignado
-- por la secuenca). En todos los casos, la fecha de ingreso sera la
-- fecha de sistema y el estado tomara el valor por defecto. La fecha
-- de fallecimiento y de baja iran a null.
-- No incluya el campo firma en el insert

