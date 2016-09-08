xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Tracer/v1";
(:: import schema at "../XSD/ESO/Tracer_v1_ESO.xsd" ::)

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $ComponentName as xs:string external;
declare variable $ComponentOperation as xs:string? external;

declare function local:get_HeaderTracer_v1($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                                           $ComponentName as xs:string, 
                                           $ComponentOperation as xs:string?) 
                                           as element() (:: schema-element(ns2:HeaderTracer) ::) {
    <ns2:HeaderTracer component="{fn:data($ComponentName)}" operation="{fn:data($ComponentOperation)}">
        {$RequestHeader}
    </ns2:HeaderTracer>
};

local:get_HeaderTracer_v1($RequestHeader, $ComponentName, $ComponentOperation)
