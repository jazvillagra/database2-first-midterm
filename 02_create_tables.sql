--create table soc_socio
CREATE TABLE soc_socio (
	id_socio number(12) not null,
	cedula varchar2(12) not null,
	ruc varchar2(12),
	nombre varchar2(50) not null,
	apellido varchar2(50) not null,
	fecha_nacimiento date not null,
	fecha_ingreso date not null,
	direccion varchar2(100) not null,
	telefono varchar2(20) not null,
	email varchar2(50) not null,
	suscripto_novedades varchar2(2) not null,
	firma blob,
	estado varchar2(1) not null,
	fecha_fallecimiento date,
	fecha_baja date,
	CONSTRAINT pk_id_socio PRIMARY KEY (id_socio),
	CONSTRAINT SOCIO_ESTADO CHECK (ESTADO IN 'A', 'I','P', 'E','F')
);
--create table cre_modalidad_prestamo
CREATE TABLE cre_modalidad_prestamo (
	cod_tipo number(3) not null,
	descripcion_mod varchar2(60) not null,
	tasa_interes_anual number(3,1) not null,
	relacion_aportes number(2) not null,
	plazo_maximo number(3) not null,
	tipo_garantia varchar2(2) not null,
	CONSTRAINT pk_id_modalidad PRIMARY KEY (cod_tipo)
);
--create table cre_solicitud_prestamos
CREATE TABLE cre_solicitud_prestamos (
	id_sol_cred number(12) not null,
	fecha_presentacion date not null DEFAULT sysdate,
	situacion varchar2(1) not null,
	monto_solicitado number(12) not null,
	monto_concedido number(12) not null,
	plazo number(3) not null,
	observacion varchar2(300),
	socio_deudor number(12) not null,
	socio_codeudor number(12) not null,
	cod_tipo number(3) not null,
	CONSTRAINT pk_id_sol_cred PRIMARY KEY (id_sol_cred),
	CONSTRAINT fk_cod_mod FOREIGN KEY (cod_tipo) REFERENCES cre_solicitud_prestamos(cod_tipo),
	CONSTRAINT fk_id_socio_deudor FOREIGN KEY (socio_deudor) REFERENCES soc_socio (id_socio),
	CONSTRAINT fk_id_socio_codeudor FOREIGN KEY (socio_codeudor) REFERENCES soc_socio(id_socio)
	CONSTRAINT SOL_PRES_SITUACION_CHECK(situacion IN ('I','A','R','X'))
);
/*
--alter table for fecha_presentacion = sysdate as default
ALTER TABLE cre_solicitud_prestamos
MODIFY fecha_presentacion DEFAULT sysdate;
*/
--create table cre_prestamos
CREATE TABLE cre_prestamos (
	nro_prestamo number(12) not null,
	fecha_generacion date not null,
	fecha_desembolso date not null,
	fecha_cancelacion date,
	monto_prestamo number(12) not null,
	estado varchar2(1) not null,
	id_sol_cred number(12) not null,
	CONSTRAINT pk_id_prestamo PRIMARY KEY (nro_prestamo),
	CONSTRAINT fk_id_sol_cred FOREIGN KEY (id_sol_cred) REFERENCES cre_solicitud_prestamos(id_sol_cred);
	CONSTRAINT estado_cre_prestamo_check CHECK (estado in ('I', 'A'))
);

-- create table cre_cuotas
CREATE TABLE cre_cuotas (
	nro_prestamo number(12) not null,
	nro_cuota number(2) not null,
	amortizacion number(12) not null,
	interes number(12) not null,
	monto_cuota number(12) not null,
	seguro_vida number(8) not null,
	interes_moratorio number(10) not null,
	fecha_vencimiento date not null,
	fecha_pago date,
	CONSTRAINT pk_id_cuo_pres PRIMARY KEY (nro_prestamo, nro_cuota),
	CONSTRAINT fk_nro_pmo FOREIGN KEY (nro_prestamo) REFERENCES cre_prestamos (nro_prestamo)
);

--create table aho_cuenta_ahorro
CREATE TABLE aho_cuenta_ahorro (
	id_cuenta number(8) not null,
	id_socio number(12) not null,
	estado varchar2(1) not null DEFAULT 'A',
	tasa_interes number(3) not null,
	fecha_apertura date not null,
	fecha_cancel date,
	saldo_bloqueado number(12) not null,
	saldo_disponible number(12) not null
	CONSTRAINT pk_id_ahorro PRIMARY KEY (id_cuenta),
	CONSTRAINT fk_id_soc_aho FOREIGN KEY (id_socio) REFERENCES soc_socio (id_socio),
	CONSTRAINT estado_aho_cuenta_ahorro_check CHECK (estado in ('A','I'))
);

--create table aho_tipo_movimiento
CREATE TABLE aho_tipo_movimiento (
	id_tipo number(3) not null,
	nombre_tipo varchar2(20) not null,
	debito_credito varchar2(1) not nul DEFAULT 'D',
	CONSTRAINT pk_id_tipo_mov PRIMARY KEY (id_tipo)
);

--create table aho_movimientos_cuenta
CREATE TABLE aho_movimientos_cuenta (
	id_movimiento number(12) not null,
	fecha_movimiento date not null,
	importe number(16) not null,
	id_tipo number(3) not null,
	id_cuenta number(8) not null,
	CONSTRAINT pk_id_mov PRIMARY KEY (id_movimiento),
	CONSTRAINT fk_tipo_mov FOREIGN KEY (id_tipo) REFERENCES aho_tipo_movimiento(id_tipo),
	CONSTRAINT fk_ id_cta_aho FOREIGN KEY (id_cuenta)
);

--create table ald_declaracion_jurada
CREATE TABLE ald_declaracion_jurada(
	id_declaracion number(10) not null,
	fecha_presentacion date, not null,
	ocupacion varchar2(30) not null,
	empresa_actual varchar2(30),
	motivo_presentacion varchar2(100) not null,
	observaciones varchar2(300),
	id_socio number(12),
	CONSTRAINT pk_id_declaracion PRIMARY KEY (id_movimiento),
	CONSTRAINT fk_id_soc_decl FOREIGN KEY (id_socio) REFERENCES soc_socio (id_socio)
);

--create table ald_conceptos
CREATE TABLE ald_conceptos (
	id_concepto numer(3) not null,
	nombre_concepto varchar2(40) not null,
	ingreso_gasto varchar2(1) not null,
	CONSTRAINT pk_id_concepto PRIMARY KEY (id_concepto)
);

--create table ald_detalle_declaracion
CREATE TABLE ald_detalle_declaracion(
	id_declaracion number(10) not null, 
	nro_item number(5) not null,
	importe number(15) not null,
	id_concepto number (3) not null,
	CONSTRAINT pk_id_det_declar
);