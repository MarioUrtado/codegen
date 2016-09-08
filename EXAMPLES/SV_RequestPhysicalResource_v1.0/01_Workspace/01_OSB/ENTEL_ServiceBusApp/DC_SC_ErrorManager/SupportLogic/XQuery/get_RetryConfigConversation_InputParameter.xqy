xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/retryConfigConversation";
(:: import schema at "../JCA/retryManagerAdapter/retryConfigConversatioin/retryConfigConversation_sp.xsd" ::)

declare variable $conversationID as xs:string external;
declare variable $correlationID as xs:string external;

declare function local:get_RetryConfigConversation_InputParameter($conversationID as xs:string, 
                                                                  $correlationID as xs:string) 
                                                                  as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_CONVERSATION_ID>{fn:data($conversationID)}</ns1:P_CONVERSATION_ID>
        <ns1:P_CORRELATION_ID>{fn:data($correlationID)}</ns1:P_CORRELATION_ID>
    </ns1:InputParameters>
};

local:get_RetryConfigConversation_InputParameter($conversationID, $correlationID)
