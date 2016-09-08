xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $MessageHeader as element() external;

declare function local:get_RequestHeader_From_MessageHeader($MessageHeader as element()) as element() (:: schema-element(ns1:RequestHeader) ::) {
    <ns1:RequestHeader>
        {$MessageHeader/*}
    </ns1:RequestHeader>
};

local:get_RequestHeader_From_MessageHeader($MessageHeader)
