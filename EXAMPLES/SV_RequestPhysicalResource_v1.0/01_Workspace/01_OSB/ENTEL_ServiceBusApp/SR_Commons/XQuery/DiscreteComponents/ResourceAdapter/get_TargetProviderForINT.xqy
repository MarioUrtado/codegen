xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $TargetProvider as  xs:string  external;
declare variable $Consumer as element() (:: schema-element(ns1:Consumer) ::) external;

declare function local:func($TargetProvider as  xs:string, 
                            $Consumer as element() (:: schema-element(ns1:Consumer) ::)) 
                            as   xs:string {
     fn:concat(
      fn:data($Consumer/@countryCode),
      substring($TargetProvider, 4, fn:string-length($TargetProvider))
    )   
};

local:func($TargetProvider, $Consumer)
