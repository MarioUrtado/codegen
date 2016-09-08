--------------------------------------------------------
--  DDL for Package Body ESB_PARAMETERMANAGER_PKG
--------------------------------------------------------
create or replace 
PACKAGE BODY ESB_PARAMETERMANAGER_PKG AS
  PROCEDURE get(p_Keys IN KEYS_T, p_KeyValues OUT sys_refcursor, p_SourceError OUT SOURCERROR_T)
  AS
    v_KeyValues KEYVALUETABLE_T := KEYVALUETABLE_T();
    v_KeyValue KEYVALUE_T := KEYVALUE_T(NULL, NULL);
    v_SourceError SOURCERROR_T := SOURCERROR_T(NULL, NULL);
    v_CountNulls NUMBER := 0;
  BEGIN
  
    FOR i IN p_Keys.FIRST .. p_Keys.LAST
    LOOP
      BEGIN
        
        SELECT key, value INTO v_KeyValue.key, v_KeyValue.value
        FROM esb_parameter
        WHERE key = p_Keys(i)
          AND rcd_status=1;
        
        v_KeyValues.EXTEND;
        v_KeyValues(v_KeyValues.COUNT) := KEYVALUE_T(v_KeyValue.key, v_KeyValue.value);
        
        IF (v_KeyValue.value IS NULL) THEN
          v_CountNulls := v_CountNulls + 1;
        END IF;
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
          NULL;
      END;
    END LOOP;
    
    IF (v_KeyValues.COUNT = 0) THEN
      v_SourceError.CODE_:= '3';
      v_SourceError.DESCRIPTION_:= 'No se encontraron los parametros especificados en el repositorio.';
    ELSIF (v_KeyValues.COUNT < p_Keys.COUNT) THEN
      v_SourceError.CODE_:= '1';
      v_SourceError.DESCRIPTION_:= 'Hay parametros faltantes en el repositorio.';
    ELSIF (v_CountNulls > 0) THEN
      v_SourceError.CODE_:= '2';
      v_SourceError.DESCRIPTION_:= 'Existen claves sin valor asignado.';
    ELSE
      v_SourceError.CODE_:= '0';
      v_SourceError.DESCRIPTION_:= 'Transaccion exitosa.';
    END IF;
      
    p_SourceError := SOURCERROR_T(v_SourceError.CODE_, v_SourceError.DESCRIPTION_);
        
    OPEN p_KeyValues FOR
      SELECT KEY, VALUE FROM TABLE(v_KeyValues);
	  
    RETURN;
  END get;
  
  PROCEDURE getMapping(p_MapInput IN MAPS_IN_T, p_MapOutput OUT sys_refcursor, p_SourceError OUT SOURCERROR_T)
  AS
    v_MapsOutput MAPS_OUT_T := MAPS_OUT_T();
    v_MapRecord MAP_OUT_T;
    v_SourceError SOURCERROR_T := SOURCERROR_T(NULL, NULL);
    v_CountNulls NUMBER := 0;
  BEGIN
    FOR i IN p_MapInput.FIRST .. p_MapInput.LAST
    LOOP
      v_MapRecord := MAP_OUT_T(NULL, NULL, NULL, NULL);
      
      BEGIN
      
        SELECT em.destination_code, em.source_code, ece.name, ecf.name
          INTO v_MapRecord.DCODE_, v_MapRecord.SCODE_, v_MapRecord.ENTITY_, v_MapRecord.FIELD_
        FROM esb_mapping em INNER JOIN esb_cdm_field ecf ON (em.field_id = ecf.id)
                            INNER JOIN esb_cdm_entity ece ON (ecf.entity_id = ece.id)
        WHERE 
          em.source_code = p_MapInput(i).SCODE_ AND 
          em.destination_system = (select id from esb_system where code = p_MapInput(i).DSYS_ and rownum = 1) AND 
          em.source_system = (select id from esb_system where code = p_MapInput(i).SSYS_  and rownum = 1) AND 
          (ecf.name = p_MapInput(i).field_ AND ece.name = p_MapInput(i).entity_ OR em.field_id IS NULL AND p_MapInput(i).field_ IS NULL) AND 
          (em.context = p_MapInput(i).CONTEXT_ OR em.context IS NULL AND p_MapInput(i).CONTEXT_ IS NULL) AND 
          ecf.rcd_status = 1 AND 
          ece.rcd_status = 1 AND 
          em.rcd_status = 1;
        
        v_MapsOutput.EXTEND;
        v_MapsOutput(v_MapsOutput.COUNT) := MAP_OUT_T(v_MapRecord.DCODE_, v_MapRecord.SCODE_, v_MapRecord.ENTITY_, v_MapRecord.FIELD_);
        
        IF (v_MapRecord.DCODE_ IS NULL) THEN
          v_CountNulls := v_CountNulls + 1;
        END IF;
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
          NULL;
      END;
    END LOOP;
	
    IF (v_MapsOutput.COUNT = 0) THEN
      v_SourceError.CODE_:= '6';
      v_SourceError.DESCRIPTION_:= 'No se encontraron los mapeos especificados en el repositorio.';
    ELSIF (v_MapsOutput.COUNT < p_MapInput.COUNT) THEN
      v_SourceError.CODE_:= '4';
      v_SourceError.DESCRIPTION_:= 'Mapeos faltantes en el repositorio.';
    ELSIF (v_CountNulls > 0) THEN
      v_SourceError.CODE_:= '5';
      v_SourceError.DESCRIPTION_:= 'Existen claves sin valor asignado.';
    ELSE
      v_SourceError.CODE_:= '0';
      v_SourceError.DESCRIPTION_:= 'Transaccion exitosa.';
    END IF;
      
    p_SourceError := SOURCERROR_T(v_SourceError.CODE_, v_SourceError.DESCRIPTION_);    
        
    OPEN p_MapOutput FOR
      SELECT DCODE_, SCODE_, ENTITY_, FIELD_ FROM TABLE(v_MapsOutput);
      
    RETURN;
  END getMapping;

  PROCEDURE getConfig(p_ConfigName IN VARCHAR2, p_Config OUT sys_refcursor, p_SourceError OUT SOURCERROR_T)
  AS
    v_KeyValues KEYVALUETABLE_T := KEYVALUETABLE_T();
    v_SourceError SOURCERROR_T := SOURCERROR_T(NULL, NULL);
    v_countNotNulls NUMBER := 0;
  BEGIN
    SELECT KEYVALUE_T(ecp.name, ecl.value) BULK COLLECT INTO v_KeyValues
    FROM esb_config ec INNER JOIN esb_config_list ecl ON (ec.id = ecl.config_id)
                       INNER JOIN esb_config_property ecp ON (ecl.property_id = ecp.id)
    WHERE ec.NAME = p_ConfigName AND ec.rcd_status = 1 AND ecl.rcd_status = 1 AND ecp.rcd_status = 1;
    
    SELECT COUNT(VALUE) INTO v_countNotNulls FROM TABLE (v_KeyValues);
    
    IF (v_KeyValues.COUNT = 0) THEN
      v_SourceError.CODE_:= '8';
      v_SourceError.DESCRIPTION_:= 'No se encontro informacion para la configuracion en el repositorio.';
    ELSIF (v_countNotNulls < v_KeyValues.COUNT) THEN
      v_SourceError.CODE_:= '7';
      v_SourceError.DESCRIPTION_:= 'Existen propiedades no valuadas en la configuracion.';
    ELSE
      v_SourceError.CODE_:= '0';
      v_SourceError.DESCRIPTION_:= 'Transaccion exitosa.';
    END IF;
    
    p_SourceError := SOURCERROR_T(v_SourceError.CODE_, v_SourceError.DESCRIPTION_);   
        
    OPEN p_Config FOR
      SELECT KEY, VALUE FROM TABLE(v_KeyValues);
  END getConfig;

  PROCEDURE getEndpoint(p_Target IN OUT TARGET_T, p_Endpoint OUT sys_refcursor, p_EndpType OUT VARCHAR2, p_EndpInstance OUT VARCHAR2, p_SourceError OUT SOURCERROR_T)
  AS
    v_KeyValues KEYVALUETABLE_T := KEYVALUETABLE_T();
    v_SourceError SOURCERROR_T := SOURCERROR_T(NULL, NULL);
    v_countNotNulls NUMBER := 0;
  BEGIN
    BEGIN
      SELECT eet.name, ee.instance INTO p_EndpType, p_EndpInstance
      FROM esb_endpoint ee INNER JOIN esb_endpoint_transport eet ON (ee.transport_id = eet.id)
                           INNER JOIN esb_system_api_operation esao ON (ee.operation_id = esao.id)
                           INNER JOIN esb_system_api esa ON (esao.system_api_id = esa.id)
                           INNER JOIN esb_system es ON (esa.system_id = es.id)
      WHERE esao.name = p_Target.operation_ AND es.code = p_Target.provider_
          AND esa.code = p_Target.api_ AND esao.version = p_Target.version_ 
          AND ee.rcd_status = 1 AND eet.rcd_status = 1
          AND esao.rcd_status = 1 AND esa.rcd_status = 1
          AND es.rcd_status = 1;
      
      EXCEPTION WHEN NO_DATA_FOUND THEN
        v_SourceError.CODE_:= '10';
        v_SourceError.DESCRIPTION_:= 'No se encontro informacion para el endpoint en el repositorio.';
    END;
    
    IF (v_SourceError.CODE_ IS NULL) THEN
      SELECT KEYVALUE_T (ecp.name, ecl.value) BULK COLLECT INTO v_KeyValues
      FROM esb_endpoint ee INNER JOIN esb_system_api_operation esao ON (ee.operation_id = esao.id)
                           INNER JOIN esb_system_api esa ON (esao.system_api_id = esa.id)
                           INNER JOIN esb_system es ON (esa.system_id = es.id)
                           INNER JOIN esb_config ec ON (ee.config_id = ec.id)
                           INNER JOIN esb_config_list ecl ON (ec.id = ecl.config_id)
                           INNER JOIN esb_config_property ecp ON (ecl.property_id = ecp.id)
      WHERE esao.name = p_Target.operation_ AND es.code = p_Target.provider_
        AND esa.code = p_Target.api_ AND esao.version = p_Target.version_
        AND ee.rcd_status = 1 AND ec.rcd_status = 1
        AND ecl.rcd_status = 1 AND ecp.rcd_status = 1;
        
      SELECT COUNT(VALUE) INTO v_countNotNulls FROM TABLE (v_KeyValues);
      
      IF (v_countNotNulls < v_KeyValues.COUNT) THEN
        v_SourceError.CODE_:= '9';
        v_SourceError.DESCRIPTION_:= 'Existen propiedades no valuadas en el endpoint.';
      ELSE
        v_SourceError.CODE_:= '0';
        v_SourceError.DESCRIPTION_:= 'Transaccion exitosa.';
      END IF;
      
      OPEN p_Endpoint FOR
        SELECT KEY, VALUE FROM TABLE(v_KeyValues);
      
    END IF;
    p_SourceError := SOURCERROR_T(v_SourceError.CODE_, v_SourceError.DESCRIPTION_);
  END getEndpoint;
END ESB_PARAMETERMANAGER_PKG;
/