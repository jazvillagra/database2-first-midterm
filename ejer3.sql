/*El campo ESTADO debe tomar los siguientes valores ‘A’(Activo), ‘I’(Inactivo), ‘P’
(Proceso de retiro) ,’ E’ (Excluido), ‘F’ (Fallecido). El valor por defecto es ‘A’*/

ALTER TABLE SOC_SOCIO 
	ADD CONSTRAINT SOCIO_ESTADO CHECK (ESTADO IN 'A', 'I','P', 'E','F')
;

/*Cuando el estado es ‘F’, la fecha de fallecimiento debe tener valor (no puede ser
nula)*/

ALTER TABLE SOC_SOCIO
	ADD CONSTRAINT SOCIO_ESTADO_FALLECIMIENTO 
		CHECK (IF (ESTADO = 'F') FECHA_FALLECIMIENTO NOT NULL )
;

/*El campo TIPO_OBLIGACION puede tener los siguientes valores: ‘A’ (Aporte) y ‘S’
(Solidaridad). Por defecto el valor es ‘A’*/

ALTER TABLE SOC_OBLIGACIONES
	ADD CONSTRAINT CHECK_TIPO_OBLIGACION CHECK (TIPO_OBLIGACION IN 'A','S') DEFAULT 'A'
;

/*El campo DEBITO_CREDITO puede tener los valores ‘D’ y ‘C’ respectivamente,
siendo el valor por defecto ‘D’.*/

ALTER TABLE AHO_TIPO_MOVIMIENTO 
	ADD CONSTRAINT CHECK_DEBITO_CREDITO CHECK (DEBITO_CREDITO IN 'D', 'C' DEFAULT 'D')
;

/*El campo ESTADO puede ser ‘A’ (Activo) o ‘I’ (Inactivo), siendo el valor por defecto
‘A’*/
ALTER TABLE AHO_CUENTA_AHORRO
	ADD CONSTRAINT CHECK_ESTADO CHECK (ESTADO IN 'A','I' DEFAULT 'A')
;

/*Si la fecha de cancelación es asignada, el estado de la cuenta debe ser 
I(Inactiva).*/

ALTER TABLE AHO_CUENTA_AHORRO
	ADD CONSTRAINT CHECK_F_CANCELACION CHECK(IF FECHA_CANCEL = NULL )