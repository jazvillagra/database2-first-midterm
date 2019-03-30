MERGE INTO AHO_CUENTA_AHORRO CA
USING (
SELECT CA.ID_CUENTA, 
(SELECT sum(MC.importe)
FROM AHO_CUENTA_AHORRO CA2 JOIN aho_movimientos_cuenta MC
ON CA2.ID_CUENTA = MC.ID_CUENTA
JOIN AHO_TIPO_MOVIMIENTO ATM
ON MC.ID_TIPO = ATM.ID_TIPO
where ATM.debito_credito='C'and CA.ID_CUENTA = CA2.ID_CUENTA) 
-
(SELECT sum(MC.importe) CA2.saldo_bloqueado
FROM AHO_CUENTA_AHORRO CA2 JOIN aho_movimientos_cuenta MC
ON CA2.ID_CUENTA = MC.ID_CUENTA
JOIN AHO_TIPO_MOVIMIENTO ATM
ON MC.ID_TIPO = ATM.ID_TIPO	
where ATM.debito_credito='D' and CA.ID_CUENTA = CA2.ID_CUENTA
group by CA2.ID_CUENTA, CA2.saldo_bloqueado) RESTA
FROM AHO_CUENTA_AHORRO CA JOIN aho_movimientos_cuenta MC
ON CA.ID_CUENTA = MC.ID_CUENTA
JOIN AHO_TIPO_MOVIMIENTO ATM
ON MC.ID_TIPO = ATM.ID_TIPO
group by CA.ID_CUENTA
) R
ON  CA.ID_CUENTA = R.ID_CUENTA)
WHEN matched THEN
	UPDATE SET CA.SALDO_DIPONIBLE = R.RESTA
;

--ESTE SIN FUNCIONA(a la version 12c no le gusta la mayuscula en el merge)
merge into aho_cuenta_ahorro ca
using (
select ca.id_cuenta, 
(select sum(mc.importe)
from aho_cuenta_ahorro ca2 join aho_movimientos_cuenta mc
on ca2.id_cuenta = mc.id_cuenta
JOIN AHO_TIPO_MOVIMIENTO atm
ON mc.ID_TIPO = atm.ID_TIPO
where atm.debito_credito='C'and ca.id_cuenta = ca2.id_cuenta) 
-
(select sum(mc.importe)+ca2.saldo_bloqueado
from aho_cuenta_ahorro ca2 join aho_movimientos_cuenta mc
on ca2.id_cuenta = mc.id_cuenta
JOIN AHO_TIPO_MOVIMIENTO atm
ON mc.ID_TIPO = atm.ID_TIPO
where atm.debito_credito='D' and ca.id_cuenta = ca2.id_cuenta
group by ca2.id_cuenta, ca2.saldo_bloqueado) Resta
from aho_cuenta_ahorro ca join aho_movimientos_cuenta mc
on ca.id_cuenta = mc.id_cuenta
JOIN AHO_TIPO_MOVIMIENTO atm
ON mc.ID_TIPO = atm.ID_TIPO
group by ca.id_cuenta
) Resul
on (ca.id_cuenta = Resul.id_cuenta)
when matched then
	update set ca.saldo_disponible = Resul.Resta
;