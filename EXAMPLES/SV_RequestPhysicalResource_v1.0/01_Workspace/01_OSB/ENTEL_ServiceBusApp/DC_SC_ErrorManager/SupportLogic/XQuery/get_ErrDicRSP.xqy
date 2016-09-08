xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ErrorManager/ErrorDictionary/v1";
(:: import schema at "../XSD/ErrorDictionary.xsd" ::)

declare variable $result as element() (:: schema-element(ns1:Result) ::) external;

declare function local:func($result as element() (:: schema-element(ns1:Result) ::)) as element() (:: schema-element(ns2:ErrDicRSP) ::) {
    <ns2:ErrDicRSP>
      {$result}
    </ns2:ErrDicRSP>
};

local:func($result)
