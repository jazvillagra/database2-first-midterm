select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'ALD_CONCEPTOS'
 group by segment_name;


select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'SOC_SOCIO'
 group by segment_name;

select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'ALD_INMUEBLES'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'ALD_DECLARACION_JURADA'
 group by segment_name;


 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'ALD_DETALLE_DECLARACION'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'SOC_OBLIGACIONES'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'SOC_DETALLE_OBLIGACIONES'
 group by segment_name;


 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'AHO_TIPO_MOVIMIENTO'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'AHO_CUENTA_AHORRO'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'AHO_MOVIMIENTOS_CUENTA'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'CRE_MODALIDAD_PRESTAMO'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'CRE_SOLICITUD_PRESTAMOS'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'CRE_PRESTAMOS'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'CRE_CUOTAS'
 group by segment_name;

 select segment_name table_name,       
       sum(bytes)/(1024) table_size_bytes 
  from user_extents 
 where segment_type='TABLE' 
   and segment_name = 'GEN_PARAMETROS'
 group by segment_name;

--para saber el tamaño de bloque para realizar los calculos
 show parameters db_block_size
