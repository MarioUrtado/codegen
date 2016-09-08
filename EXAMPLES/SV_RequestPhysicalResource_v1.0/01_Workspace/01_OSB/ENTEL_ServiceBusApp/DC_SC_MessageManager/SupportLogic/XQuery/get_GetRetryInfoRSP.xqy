xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/MessageManager/RetryInfo/v1";
(:: import schema at "../XSD/RetryInfo.xsd" ::)

declare variable $GetRetryStatusRSP as element() external;
declare variable $status as xs:string external;

declare function local:get_GetRetryInfoRSP($GetRetryStatusRSP as element()?, $status as xs:string) as element() (:: schema-element(ns1:getRetryInfoRSP) ::) {
    <ns1:getRetryInfoRSP>
        <ns1:Result isRetry="{$status}">
            <ns1:Message>{$GetRetryStatusRSP}</ns1:Message>
        </ns1:Result>
    </ns1:getRetryInfoRSP>
};

local:get_GetRetryInfoRSP($GetRetryStatusRSP, $status )
