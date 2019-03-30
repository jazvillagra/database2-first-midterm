SQL> DESC CRE_SOLICITUD_PRESTAMOS                       
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID_SOL_CRED                               NOT NULL NUMBER(12)
 FECHA_PRESENTACION                                 DATE
 SITUACION                                 NOT NULL VARCHAR2(1)
 MONTO_SOLICITADO                          NOT NULL NUMBER(12)
 MONTO_CONCEDIDO                           NOT NULL NUMBER(12)
 PLAZO                                     NOT NULL NUMBER(3)
 OBSERVACION                                        VARCHAR2(300)
 SOCIO_DEUDOR                              NOT NULL NUMBER(12)
 SOCIO_CODEUDOR                            NOT NULL NUMBER(12)
 COD_TIPO                                  NOT NULL NUMBER(3)

 INSERT TABLE CRE_SOLICITUD_PRESTAMOS VALUES(1,TRUNC(SYSDATE),)