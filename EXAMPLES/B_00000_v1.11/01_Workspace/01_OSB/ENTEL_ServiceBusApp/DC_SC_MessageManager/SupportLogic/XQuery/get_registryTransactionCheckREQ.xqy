xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registryTransactionCheck";
(:: import schema at "../JCA/registryTransactionCheck/registryTransactionCheck_sp.xsd" ::)

declare variable $messageTxID as xs:int external;
declare variable $conversationID as xs:string external;
declare variable $responseMessage as xs:string external;
declare variable $resultCode as xs:string external;
declare variable $resultDesc as xs:string external;

declare function local:get_registryTransactionCheckREQ($messageTxID as xs:int, 
                                                       $conversationID as xs:string,
                                                       $responseMessage as xs:string,
                                                       $resultCode as xs:string,
                                                       $resultDesc as xs:string) 
                                                       as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_MESSAGE_TX_ID>{fn:data($messageTxID)}</ns1:P_MESSAGE_TX_ID>
        <ns1:P_CONVERSATION_ID>{fn:data($conversationID)}</ns1:P_CONVERSATION_ID>
        <ns1:P_RESPONSE_MSG>{$responseMessage}</ns1:P_RESPONSE_MSG>
        <ns1:P_RESULT_CODE>{fn:data($resultCode)}</ns1:P_RESULT_CODE>
        <ns1:P_RESULT_DESC>{fn:data($resultDesc)}</ns1:P_RESULT_DESC>
    </ns1:InputParameters>
};

local:get_registryTransactionCheckREQ($messageTxID, $conversationID, $responseMessage, $resultCode, $resultDesc)
