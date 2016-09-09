xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.entel.cl/CSM/RA/%SYSTEM_API%/%OPERATION%/v1";
(:: import schema at "../CSC/%SYSTEM_API%_%OPERATION%_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns5 = "http://www.entel.cl/SC/ParameterManager/getMapping/v1";
(:: import schema at "../../../../DC_SC_ParameterManager/SupportAPI/XSD/CSM/getMapping_ParameterManager_v1_CSM.xsd" ::)

declare variable $AdapterRSP as element()? (:: schema-element(ns3:%SYSTEM_API%_%OPERATION%_RSP) ::) external;
declare variable $GetMappingRSP as element() (:: schema-element(ns5:GetMappingRSP) ::) external;

declare function local:get_%SYSTEM_API%_%OPERATION%_RSPMappings($AdapterRSP as element()? (:: schema-element(ns3:%SYSTEM_API%_%OPERATION%_RSP) ::)
                                                                      ,$GetMappingRSP as element()(:: schema-element(ns5:GetMappingRSP) ::)) 
                                                                  as element() (:: schema-element(ns3:%SYSTEM_API%_%OPERATION%_RSP) ::) {
    <ns3:%SYSTEM_API%_%OPERATION%_RSP>
        {$AdapterRSP/*[1]}
        <ns3:Body>
        	(: Delete STUB element :)
        	<STUB>{$GetMappingRSP/*[1]}</STUB>
        </ns3:Body>
    </ns3:%SYSTEM_API%_%OPERATION%_RSP>
};

local:get_%SYSTEM_API%_%OPERATION%_RSPMappings($AdapterRSP, $GetMappingRSP)