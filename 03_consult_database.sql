-- 8) Se requiere tener la vista materializada V_SOCIOS con la siguiente información
-- dada en el ejercitario. La vista se refrescará iniciando a partir de su creación
-- y posteriormente todos los días a las 22:00
CREATE MATERIALIZED VIEW V_SOCIOS	
BUILD IMMEDIATE
REFRESH START WITH (SYSDATE) NEXT (TRUNC(SYSDATE)+1) + 22/24
AS
SELECT 
	S.ID_SOCIO,
	S.CEDULA,
	S.NOMBRE || ' ' || S.APELLIDO Nombre_y_apellido,
	SUM(CA.SALDO_DISPONIBLE) Disponible,
	SUM(CASE CP.ESTADO WHEN 'A' THEN CC.MONTO_CUOTA ELSE 0 end) Deuda,
	SUM(CASE SC.TIPO_OBLIGACION WHEN 'A' THEN SC.TOTAL_A_ABONAR ELSE 0 end) Aporte
	FROM SOC_SOCIO S JOIN AHO_CUENTA_AHORRO CA ON S.ID_SOCIO = CA.ID_SOCIO
	JOIN CRE_SOLICITUD_PRESTAMOS CSP ON S.ID_SOCIO = CSP.SOCIO_DEUDOR
	JOIN CRE_PRESTAMOS CP ON CSP.ID_SOL_CRED = CP.ID_SOL_CRED
	JOIN CRE_CUOTAS CC ON CP.NRO_PRESTAMO = CC.NRO_PRESTAMO
	JOIN SOC_OBLIGACIONES SC ON SC.ID_SOCIO = S.ID_SOCIO
	GROUP BY  S.ID_SOCIO,
	S.CEDULA,
	S.NOMBRE || ' ' || S.APELLIDO;

-- 9)Cree una vista materializada V_PRESTAMOS que liste la situación de todos los socios
-- que tengan préstamos activos. La vista se actualizará cada hora