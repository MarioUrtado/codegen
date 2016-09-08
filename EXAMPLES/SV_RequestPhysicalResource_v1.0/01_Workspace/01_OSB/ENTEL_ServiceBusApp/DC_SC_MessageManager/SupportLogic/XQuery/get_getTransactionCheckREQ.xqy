xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getTransactionCheck";
(:: import schema at "../JCA/getTransactionCheck/getTransactionCheck_sp.xsd" ::)

declare variable $event_id as xs:string external;
declare variable $proc_id as xs:string external;
declare variable $client_req_timestamp as xs:dateTime external;
declare variable $capability as xs:string external;

declare function local:getTransactionCheckREQ($event_id as xs:string, 
                                              $proc_id as xs:string, 
                                              $client_req_timestamp as xs:dateTime,
                                              $capability as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_EVENT_ID>{fn:data($event_id)}</ns1:P_EVENT_ID>
        <ns1:P_PROC_ID>{fn:data($proc_id)}</ns1:P_PROC_ID>
        <ns1:P_CLIENT_REQ_TIMESTAMP>{fn:data($client_req_timestamp)}</ns1:P_CLIENT_REQ_TIMESTAMP>
        <ns1:P_CAPABILITY_ID>{fn:data($capability)}</ns1:P_CAPABILITY_ID>
    </ns1:InputParameters>
};

local:getTransactionCheckREQ($event_id, $proc_id, $client_req_timestamp, $capability)
