xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getMapping/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getMapping_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getMappingParameterManagerAdapter";
(:: import schema at "../JCA/getMappingParameterManagerAdapter/getMappingParameterManagerAdapter_sp.xsd" ::)

declare variable $getMappingREQ as element() (:: schema-element(ns1:GetMappingREQ) ::) external;

declare function local:getMappingREQ_Adapter($getMappingREQ as element() (:: schema-element(ns1:GetMappingREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_MAPINPUT>
            {
                for $Map in $getMappingREQ/ns1:Maps/ns1:Map
                order by $Map/@sCode,$Map/@context,$Map/@entity,$Map/@field,$Map/@dSys,$Map/@sSys
                return 
                <ns2:P_MAPINPUT_ITEM>
                    <ns2:SCODE_>{fn:data($Map/@sCode)}</ns2:SCODE_>
                    {
                        if($Map/@context)
                        then <ns2:CONTEXT_>{fn:data($Map/@context)}</ns2:CONTEXT_>
                        else ()
                    }
                    {
                        if($Map/@entity)
                        then <ns2:ENTITY_>{fn:data($Map/@entity)}</ns2:ENTITY_>
                        else ()
                    }
                    {
                        if($Map/@field)
                        then <ns2:FIELD_>{fn:data($Map/@field)}</ns2:FIELD_>
                        else ()
                    }
                    <ns2:DSYS_>{fn:data($Map/@dSys)}</ns2:DSYS_>
                    <ns2:SSYS_>{fn:data($Map/@sSys)}</ns2:SSYS_>
                </ns2:P_MAPINPUT_ITEM>
            }
        </ns2:P_MAPINPUT>
    </ns2:InputParameters>
};

local:getMappingREQ_Adapter($getMappingREQ)