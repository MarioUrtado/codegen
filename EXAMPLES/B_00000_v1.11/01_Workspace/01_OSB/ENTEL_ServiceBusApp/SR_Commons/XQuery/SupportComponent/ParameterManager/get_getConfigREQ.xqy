xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/SC/ParameterManager/getConfig/v1";

declare variable $requestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $configName as xs:string external;

declare function local:getConfigREQ($requestHeader as element() (:: schema-element(ns2:RequestHeader) ::), 
                                    $configName as xs:string) 
                                    as element() {
    <ns1:GetConfigREQ>
        {$requestHeader}
        <ns1:Config>{$configName}</ns1:Config>
    </ns1:GetConfigREQ>
};

local:getConfigREQ($requestHeader,$configName)