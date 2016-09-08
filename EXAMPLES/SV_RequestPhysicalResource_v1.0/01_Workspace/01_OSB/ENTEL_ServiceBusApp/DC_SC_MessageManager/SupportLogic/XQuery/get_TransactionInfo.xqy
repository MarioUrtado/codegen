xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/SC/MessageManager/CheckExecutorHelper/v1";
(:: import schema at "../XSD/CheckExecutorHelper.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getTransactionInfo";
(:: import schema at "../JCA/getTransactionInfo/getTransactionInfo_sp.xsd" ::)

declare variable $RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $CapabilityID as xs:string external;
declare variable $isRetry as xs:string external;
declare variable $getTransactionInfoRSP as element() (:: schema-element(ns3:OutputParameters) ::) external;


declare function local:refactor( $transactions as element()) as element(){
      <Transactions>    
      {for $row in $transactions/*:MESSAGE_TRANSACTION[1]/*:Row 
      return 
          <Transaction ID="{$row/*:Column[ upper-case(@name)='ID']/text()}" 
              STATUS="{$row/*:Column[ upper-case(@name)='STATUS']/text()}" 
              MSG_TIMESTAMP="{$row/*:Column[ upper-case(@name)='MSG_TIMESTAMP']/text()}" 
              CAPABILITY_ID="{$row/*:Column[ upper-case(@name)='CAPABILITY_ID']/text()}" 
              SEQUENCE="{$row/*:Column[ upper-case(@name)='SEQUENCE']/text()}" 
              CORRELATION_ID="{$row/*:Column[ upper-case(@name)='CORRELATION_ID']/text()}" />
          }
      </Transactions>
};

declare function local:get_TransactionInfo($RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::), 
                                           $CapabilityID as xs:string, 
                                           $getTransactionInfoRSP as element(), (:: schema-element(ns3:OutputParameters) ::)
                                           $isRetry as xs:string
                                           ) as element() (:: schema-element(ns1:TransactionInfo) ::) {
    let $Txs := local:refactor($getTransactionInfoRSP)
    return 
      if ($isRetry = 'true') 
      then if ($Txs/*[@CORRELATION_ID = $RequestHeader/*[2]/@correlationID ]) 
            then <ns1:TransactionInfo id="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @CORRELATION_ID = $RequestHeader/*[2]/@correlationID]/@ID}" 
                                 status="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @CORRELATION_ID = $RequestHeader/*[2]/@correlationID]/@STATUS}" 
                                 message_timestamp="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @CORRELATION_ID = $RequestHeader/*[2]/@correlationID]/@MSG_TIMESTAMP}" 
                                 capabilityTxOwner="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @CORRELATION_ID = $RequestHeader/*[2]/@correlationID]/@CAPABILITY_ID}" 
                                 sequence="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @CORRELATION_ID = $RequestHeader/*[2]/@correlationID]/@SEQUENCE}"/>
            else <ns1:TransactionInfo/>
      else if ($Txs/*[ @SEQUENCE = 0 ]) 
            then <ns1:TransactionInfo id="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @SEQUENCE = 0]/@ID}" 
                                 status="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @SEQUENCE = 0]/@STATUS}" 
                                 message_timestamp="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @SEQUENCE = 0]/@MSG_TIMESTAMP}" 
                                 capabilityTxOwner="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @SEQUENCE = 0]/@CAPABILITY_ID}" 
                                 sequence="{$Txs/*[@CAPABILITY_ID = $CapabilityID and @SEQUENCE = 0]/@SEQUENCE}"/>
            else <ns1:TransactionInfo/>
      

};

local:get_TransactionInfo($RequestHeader, $CapabilityID, $getTransactionInfoRSP, $isRetry)
