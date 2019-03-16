-- 4) Cree la secuencia SEQ_SOCIO iniciando en 1 y con incrementos de 1
CREATE SEQUENCE seq_socio START WITH 1 INCREMENT BY 1;
COMMIT;

-- 5) Inserte datos en la tabla soc_socio a partir de la tabla b_personas
-- fisicas de su esquema de lal clase (el id del socio sera asignado
-- por la secuenca). En todos los casos, la fecha de ingreso sera la
-- fecha de sistema y el estado tomara el valor por defecto. La fecha
-- de fallecimiento y de baja iran a null.
-- No incluya el campo firma en el insert
INSERT INTO SOC_SOCIO 
	(ID_SOCIO, CEDULA, RUC,
	NOMBRE, APELLIDO, FECHA_NACIMIENTO,
	FECHA_INGRESO, DIRECCION, TELEFONO,
	EMAIL, SUSCRIPTO_NOVEDADES, ESTADO,
	FECHA_FALLECIMIENTO, FECHA_BAJA)
	SELECT
		seq_socio.nextval, P.CEDULA, P.RUC,
		P.NOMBRE, P.APELLIDO, P.FECHA_NACIMIENTO,
		TRUNC(SYSDATE), P.DIRECCION, P.TELEFONO,
		P.CORREO_ELECTRONICO, 'N', 'A',
		NULL, NULL
	FROM B_PERSONAS P 
	WHERE P.CEDULA IS NOT NULL;
COMMIT;

-- 6) En la tabla CRE_MODALIDAD_PRESTAMO, el campo DESCRIPCION_MOD debe ser
-- ampliado a 100
ALTER TABLE CRE_MODALIDAD_PRESTAMO
	MODIFY DESCRIPCION_MOD VARCHAR2(100);
COMMIT;

-- 7) Actualice el SALDO_DISPONIBLE de la tabla AHO_CUENTA_AHORRO de la siguiente
-- manera: SALDO_DISPONIBLE = ∑ importe de los MOVIMIENTOS cuyo tipo es Crédito – 
-- (∑importe de los MOVIMIENTOS cuyo tipo es Débito + SALDO_BLOQUEADO).

CREATE OR REPLACE VIEW importe_credito_cuentas AS
SELECT CA.id_cuenta id_cuenta, sum(nvl(importe,0)) importe
FROM
	AHO_MOVIMIENTOS_CUENTA MC
	INNER JOIN AHO_TIPO_MOVIMIENTO TM ON MC.ID_TIPO = TM.ID_TIPO
	INNER JOIN AHO_CUENTA_AHORRO CA ON MC.id_cuenta = CA.id_cuenta
WHERE DEBITO_CREDITO = 'C'
GROUP BY CA.id_cuenta;

COMMIT;

CREATE OR REPLACE VIEW importe_debito_cuentas AS
SELECT CA.id_cuenta id_cuenta, sum(nvl(importe+saldo_bloqueado, 0)) importe
FROM
	AHO_MOVIMIENTOS_CUENTA MC
	INNER JOIN AHO_TIPO_MOVIMIENTO TM ON MC.ID_TIPO = TM.ID_TIPO
	INNER JOIN AHO_CUENTA_AHORRO CA ON MC.id_cuenta = CA.id_cuenta
WHERE DEBITO_CREDITO = 'D'
GROUP BY CA.id_cuenta;

COMMIT;

CREATE OR REPLACE VIEW importe_total AS
SELECT sum(nvl(imc.importe-idc.importe,0)) importe, imc.id_cuenta id
FROM
	importe_credito_cuentas imc
	JOIN importe_debito_cuentas idc ON idc.id_cuenta = imc.id_cuenta
GROUP BY imc.id_cuenta;

COMMIT;
/* Descomentar cuando se sepa como hacer el merge
MERGE INTO AHO_CUENTA_AHORRO CA
	USING importe_total IT
		ON CA.id_cuenta = IT.id_cuenta
WHEN MATCHED THEN
	UPDATE
		SET SALDO_DISPONIBLE = IT.importe;*/
