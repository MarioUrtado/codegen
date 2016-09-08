xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $processCode as xs:string external;
declare variable $processArea as xs:string external;
declare variable $origenEventID as xs:string external;
declare variable $sysCode as xs:string external;
declare variable $operationCode as xs:string external;
declare variable $enterpriseCode as xs:string external;
declare variable $countryCode as xs:string external;
declare variable $clientReqTimestamp as xs:dateTime external;

declare function local:get_RequestHeader($processCode as xs:string, 
                                         $processArea as xs:string, 
                                         $origenEventID as xs:string, 
                                         $sysCode as xs:string, 
                                         $operationCode as xs:string, 
                                         $enterpriseCode as xs:string, 
                                         $countryCode as xs:string, 
                                         $clientReqTimestamp as xs:dateTime) 
                                         as element() (:: schema-element(ns1:RequestHeader) ::) {
    <ns1:RequestHeader>
        <ns1:Consumer sysCode="{$sysCode}" enterpriseCode="{$enterpriseCode}" countryCode="{$countryCode}">
        </ns1:Consumer>
        <ns1:Trace clientReqTimestamp="{$clientReqTimestamp}" processID="{concat($processCode,$processArea)}" eventID="{concat($sysCode, $operationCode, concat(year-from-dateTime(fn:current-dateTime()), month-from-dateTime(fn:current-dateTime()), day-from-dateTime(fn:current-dateTime()), hours-from-dateTime(fn:current-dateTime()), minutes-from-dateTime(fn:current-dateTime()), seconds-from-dateTime(fn:current-dateTime())), substring($origenEventID,1,5), '000')}">
        </ns1:Trace>
    </ns1:RequestHeader>
};

local:get_RequestHeader($processCode, $processArea, $origenEventID, $sysCode, $operationCode, $enterpriseCode, $countryCode, $clientReqTimestamp)
