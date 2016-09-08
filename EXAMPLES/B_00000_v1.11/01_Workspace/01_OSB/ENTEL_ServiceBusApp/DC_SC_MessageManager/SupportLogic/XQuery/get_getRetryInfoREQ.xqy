xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace ns1="http://www.entel.cl/SC/MessageManager/RetryInfo/v1";
(:: import schema at "../XSD/RetryInfo.xsd" ::)

declare variable $RequestHeader as element() external;
declare variable $messageType as xs:string external;

declare function local:getRetryInfoREQ($RequestHeader as element(), $messageType as xs:string) as element() (:: schema-element(ns1:getRetryInfoREQ) ::) {
    <ns1:getRetryInfoREQ messageType="{$messageType}">
        {$RequestHeader}
    </ns1:getRetryInfoREQ>
};

local:getRetryInfoREQ( $RequestHeader , $messageType )