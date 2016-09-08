xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getEndpoint/v1";

declare namespace ns3="http://www.entel.cl/ESO/EndpointConfiguration/v1";
(:: import schema at "../../../XSD/ESO/EndpointConfiguration_v1_ESO.xsd" ::)

declare variable $requestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $target as element() (:: schema-element(ns3:Target) ::) external;


declare function local:getEndpointREQ_wTarget($requestHeader as element() (:: schema-element(ns2:RequestHeader) ::), 
                                                       $target as element() (:: schema-element(ns3:Target) ::)) 
                                                       as element() {
    <ns1:GetEndpointREQ>
        {$requestHeader}
        {$target}
    </ns1:GetEndpointREQ>
};

local:getEndpointREQ_wTarget($requestHeader, $target)
