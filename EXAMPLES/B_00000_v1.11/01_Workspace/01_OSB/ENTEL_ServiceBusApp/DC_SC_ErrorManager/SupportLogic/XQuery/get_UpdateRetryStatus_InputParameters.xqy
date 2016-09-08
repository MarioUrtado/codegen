xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/udpateRetryStatus";
(:: import schema at "../JCA/retryManagerAdapter/updateRetryStatus/udpateRetryStatus_sp.xsd" ::)

declare variable $conversationID as xs:string external;
declare variable $correlationID as xs:string external;
declare variable $status as xs:string external;

declare function local:get_UpdateRetryStatus_InputParameters($conversationID as xs:string, 
                                                             $correlationID as xs:string, 
                                                             $status as xs:string) 
                                                             as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_CONVERSATION_ID>{fn:data($conversationID)}</ns1:P_CONVERSATION_ID>
        <ns1:P_CORRELATION_ID>{fn:data($correlationID)}</ns1:P_CORRELATION_ID>
        <ns1:P_STATUS>{fn:data($status)}</ns1:P_STATUS>
    </ns1:InputParameters>
};

local:get_UpdateRetryStatus_InputParameters($conversationID, $correlationID, $status)
