xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $Trace as element() (:: schema-element(ns1:Trace) ::) external;

declare function local:get_DefaultServiceMappingContext($Trace as element() (:: schema-element(ns1:Trace) ::)) as xs:string {
    fn:concat(
      fn:data($Trace/ns1:Service/@code),
      '@',
      fn:data($Trace/ns1:Service/@operation)
    )   
};

local:get_DefaultServiceMappingContext($Trace)
