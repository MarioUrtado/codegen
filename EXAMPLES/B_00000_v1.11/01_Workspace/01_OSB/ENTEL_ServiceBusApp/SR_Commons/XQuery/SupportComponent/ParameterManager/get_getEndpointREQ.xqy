xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getEndpoint/v1";

declare namespace ns3="http://www.entel.cl/ESO/EndpointConfiguration/v1";
(:: import schema at "../../../XSD/ESO/EndpointConfiguration_v1_ESO.xsd" ::)

declare variable $requestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $providerCode as xs:string external;
declare variable $apiCode as xs:string external;
declare variable $operationCode as xs:string external;
declare variable $operationVersion as xs:string external;

declare function local:getEndpointREQ($requestHeader as element() (:: schema-element(ns2:RequestHeader) ::), 
                                                       $providerCode as xs:string, 
                                                       $apiCode as xs:string,
                                                       $operationCode as xs:string, 
                                                       $operationVersion as xs:string) 
                                                       as element() {
    <ns1:GetEndpointREQ>
        {$requestHeader}
        <ns3:Target operation="{fn:data($operationCode)}" provider="{fn:data($providerCode)}" api="{fn:data($apiCode)}" version="{fn:data($operationVersion)}">
        </ns3:Target>
    </ns1:GetEndpointREQ>
};

local:getEndpointREQ($requestHeader, $providerCode, $apiCode, $operationCode, $operationVersion)
