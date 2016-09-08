xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getTransactionInfo";
(:: import schema at "../JCA/getTransactionInfo/getTransactionInfo_sp.xsd" ::)

declare variable $id as xs:int external;
declare variable $status as xs:int external;
declare variable $msg_timestamp as xs:dateTime external;
declare variable $sequence as xs:int external;

declare function local:get_getTransactionInfoRSP($id as xs:int, $status as xs:int, $msg_timestamp as xs:dateTime, $sequence as xs:int) as element() (:: schema-element(ns1:OutputParameters) ::) {
    <ns1:OutputParameters>
        <ns1:MESSAGE_TRANSACTION>
            <ns1:Row>
                <ns1:Column name="ID" sqltype="NUMBER">{$id}</ns1:Column>
                <ns1:Column name="STATUS" sqltype="VARCHAR2">{$status}</ns1:Column>
                <ns1:Column name="MSG_TIMESTAMP" sqltype="TIMESTAMP">{$msg_timestamp}</ns1:Column>
                <ns1:Column name="SEQUENCE" sqltype="NUMBER">{$sequence}</ns1:Column>
            </ns1:Row>
        </ns1:MESSAGE_TRANSACTION>
    </ns1:OutputParameters>
};

local:get_getTransactionInfoRSP($id, $status, $msg_timestamp, $sequence)
