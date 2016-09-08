xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getEndpoint/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getEndpoint_ParameterManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getEndpointParameterManagerAdapter";
(:: import schema at "../JCA/getEndpointParameterManagerAdapter/getEndpointParameterManagerAdapter_sp.xsd" ::)

declare namespace ns3="http://www.entel.cl/ESO/EndpointConfiguration/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/EndpointConfiguration_v1_ESO.xsd" ::)

declare variable $GetEndpointREQ as element() (:: schema-element(ns1:GetEndpointREQ) ::) external;

declare function local:getEndpointReq_Adapter($GetEndpointREQ as element() (:: schema-element(ns1:GetEndpointREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_TARGET>
            <ns2:OPERATION_>{fn:data($GetEndpointREQ/ns3:Target/@operation)}</ns2:OPERATION_>
            <ns2:PROVIDER_>{fn:data($GetEndpointREQ/ns3:Target/@provider)}</ns2:PROVIDER_>
            {
                if ($GetEndpointREQ/ns3:Target/@api)
                then <ns2:API_>{fn:data($GetEndpointREQ/ns3:Target/@api)}</ns2:API_>
                else ()
            }
            {
                if ($GetEndpointREQ/ns3:Target/@version)
                then <ns2:VERSION_>{fn:data($GetEndpointREQ/ns3:Target/@version)}</ns2:VERSION_>
                else ()
            }
        </ns2:P_TARGET>
    </ns2:InputParameters>
};

local:getEndpointReq_Adapter($GetEndpointREQ)
