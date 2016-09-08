xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $description as xs:string? external;

declare function local:get_ResultOK($description as xs:string?) as element() (:: schema-element(ns1:Result) ::) {
    <ns1:Result status="OK" description="{if($description != '') then $description else 'Ejecución Exitosa.'}"/>
};

local:get_ResultOK($description)
