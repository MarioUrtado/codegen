xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $Result as element() (:: schema-element(ns2:Result) ::) external;

declare function local:get_ResponseHeader_v1($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), $Result as element() (:: schema-element(ns2:Result) ::)) as element() (:: schema-element(ns1:ResponseHeader) ::) {
    <ns1:ResponseHeader>
        {$RequestHeader/*}
        {$Result}
    </ns1:ResponseHeader>
};

local:get_ResponseHeader_v1($RequestHeader, $Result)
