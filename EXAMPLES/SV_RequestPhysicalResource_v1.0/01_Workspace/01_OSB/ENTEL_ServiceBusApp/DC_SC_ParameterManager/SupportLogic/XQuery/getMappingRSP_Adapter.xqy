xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ParameterManager/getMapping/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getMapping_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getMappingParameterManagerAdapter";
(:: import schema at "../JCA/getMappingParameterManagerAdapter/getMappingParameterManagerAdapter_sp.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $Result as element()? (:: schema-element(ns3:Result) ::) external;

declare function local:getMappingRSP_Adapter($OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::),
                                             $Result as element()? (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:GetMappingRSP) ::) {
    <ns2:GetMappingRSP>
    {
      if ($OutputParameters/ns1:P_MAPOUTPUT/ns1:P_MAPOUTPUT_Row) then
        <ns2:Maps>
            {
                for $P_MAPOUTPUT_Row in $OutputParameters/ns1:P_MAPOUTPUT/ns1:P_MAPOUTPUT_Row
                return 
                <ns2:Value 
                    dCode="{fn:data($P_MAPOUTPUT_Row/ns1:DCODE)}" 
                    sCode="{fn:data($P_MAPOUTPUT_Row/ns1:SCODE)}">
                {
                    if($P_MAPOUTPUT_Row/ns1:FIELD)
                    then attribute field {fn:data($P_MAPOUTPUT_Row/ns1:FIELD)}
                    else ()
                }
                {
                    if($P_MAPOUTPUT_Row/ns1:ENTITY)
                    then attribute entity {fn:data($P_MAPOUTPUT_Row/ns1:ENTITY)}
                    else ()
                }
                </ns2:Value>
            }
        </ns2:Maps>
      else ()
    }
        {$Result}
    </ns2:GetMappingRSP>
};

local:getMappingRSP_Adapter($OutputParameters, $Result)