xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getTransactionInfo";
(:: import schema at "../JCA/getTransactionInfo/getTransactionInfo_sp.xsd" ::)

declare variable $eventID as xs:string external;
declare variable $processID as xs:string external;
declare variable $clientReqTimestamp as xs:dateTime external;
declare variable $capabilityID as xs:int external;
declare variable $correlationID as xs:string external;

declare function local:get_getTransactionInfo($eventID as xs:string, 
                                              $processID as xs:string, 
                                              $clientReqTimestamp as xs:dateTime, 
                                              $capabilityID as xs:int,
                                              $correlationID as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_EVENT_ID>{fn:data($eventID)}</ns1:P_EVENT_ID>
        <ns1:P_PROC_ID>{fn:data($processID)}</ns1:P_PROC_ID>
        <ns1:P_CLIENT_REQ_TIMESTAMP>{fn:data($clientReqTimestamp)}</ns1:P_CLIENT_REQ_TIMESTAMP>
        <ns1:P_CAPABILITY_ID>{fn:data($capabilityID)}</ns1:P_CAPABILITY_ID>
        <ns1:p_CORRELATION_ID>{fn:data($correlationID)}</ns1:p_CORRELATION_ID>
    </ns1:InputParameters>
};

local:get_getTransactionInfo($eventID, $processID, $clientReqTimestamp, $capabilityID, $correlationID )
