xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $errorCode as xs:string external;
declare variable $errorDescription as xs:string? external;

declare function local:get_ErrorMetadata($errorCode as xs:string, 
                                         $errorDescription as xs:string?) 
                                         as element() (:: schema-element(ns1:ErrorMetadata) ::) {
    <ns1:ErrorMetadata code="{$errorCode}" description="{$errorDescription}"/>
};

local:get_ErrorMetadata($errorCode, $errorDescription)
